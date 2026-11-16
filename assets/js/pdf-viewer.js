// Shared PDF.js viewer (CV and recommendation letters), styled like a browser PDF viewer:
// a bar on top of the document (page "1 / N" · zoom − 100% +, centered) and a scrolling area
// where every page is a canvas with a selectable text layer and clickable links.
// Ctrl/⌘ + wheel (or a trackpad pinch) also zooms. Falls back to an <iframe> without PDF.js.
(() => {
  const has_pdfjs = Boolean(window.pdfjsLib);
  if (has_pdfjs) {
    pdfjsLib.GlobalWorkerOptions.workerSrc =
      "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js";
  }

  // Zoom is relative to "fit width" (1 = the page exactly fills the viewer).
  const zoom_levels = [0.5, 0.75, 1, 1.25, 1.5, 2, 2.5, 3];
  const fit_zoom_index = zoom_levels.indexOf(1);
  // Keeps very zoomed pages from allocating huge canvases (pixels per page).
  const max_canvas_pixels = 16_000_000;

  const pdf_documents = new Map(); // pdf url -> loading promise
  const load_pdf = (pdf_url) => {
    if (!pdf_documents.has(pdf_url)) pdf_documents.set(pdf_url, pdfjsLib.getDocument(pdf_url).promise);
    return pdf_documents.get(pdf_url);
  };

  const create_element = (tag, class_name, properties = {}) =>
    Object.assign(document.createElement(tag), { className: class_name }, properties);

  const add_link_overlays = async (page, viewport, page_element) => {
    for (const annotation of await page.getAnnotations()) {
      if (annotation.subtype !== "Link" || !annotation.url) continue;
      const [left, top, right, bottom] = viewport.convertToViewportRectangle(annotation.rect);
      const link = create_element("a", "pdf-page__link", { href: annotation.url, target: "_blank", rel: "noopener" });
      link.setAttribute("aria-label", annotation.url);
      Object.assign(link.style, {
        left: `${(Math.min(left, right) / viewport.width) * 100}%`,
        top: `${(Math.min(top, bottom) / viewport.height) * 100}%`,
        width: `${(Math.abs(right - left) / viewport.width) * 100}%`,
        height: `${(Math.abs(bottom - top) / viewport.height) * 100}%`,
      });
      page_element.append(link);
    }
  };

  const render_page = async (page, scale) => {
    const css_viewport = page.getViewport({ scale });
    const pixel_ratio = Math.min(
      window.devicePixelRatio || 1,
      3,
      Math.sqrt(max_canvas_pixels / (css_viewport.width * css_viewport.height))
    );
    const render_viewport = page.getViewport({ scale: scale * pixel_ratio });

    const canvas = create_element("canvas", "pdf-page__canvas", {
      width: Math.floor(render_viewport.width),
      height: Math.floor(render_viewport.height),
    });
    await page.render({ canvasContext: canvas.getContext("2d"), viewport: render_viewport }).promise;

    const page_element = create_element("div", "pdf-page");
    page_element.style.width = `${css_viewport.width}px`;
    page_element.style.aspectRatio = `${css_viewport.width} / ${css_viewport.height}`;
    // PDF.js sizes the text layer's glyphs from this variable.
    page_element.style.setProperty("--scale-factor", String(scale));
    page_element.append(canvas);

    // Invisible, positioned text on top of the canvas, so it can be selected and copied.
    const text_layer = create_element("div", "textLayer");
    page_element.append(text_layer);
    await pdfjsLib.renderTextLayer({
      textContentSource: await page.getTextContent(),
      container: text_layer,
      viewport: css_viewport,
    }).promise;

    await add_link_overlays(page, css_viewport, page_element);
    return page_element;
  };

  // host: the element that becomes the viewer (its content is replaced).
  window.create_pdf_viewer = ({ host, pdf_url, title }) => {
    // ---------- Bar: page indicator · zoom (the title is only announced, not shown) ----------
    const bar = create_element("div", "pdf-viewer__bar");

    const page_group = create_element("div", "pdf-viewer__group");
    const page_input = create_element("input", "pdf-viewer__page-input", {
      type: "text",
      inputMode: "numeric",
      value: "1",
    });
    page_input.setAttribute("aria-label", "Page number");
    const page_count_element = create_element("span", "pdf-viewer__page-count", { textContent: "/ –" });
    page_group.append(page_input, page_count_element);

    const make_button = (label, text) => {
      const button = create_element("button", "pdf-viewer__button", { type: "button", textContent: text, title: label });
      button.setAttribute("aria-label", label);
      return button;
    };
    const zoom_group = create_element("div", "pdf-viewer__group");
    zoom_group.setAttribute("role", "group");
    zoom_group.setAttribute("aria-label", "Zoom");
    const zoom_out_button = make_button("Zoom out", "−");
    const zoom_label_button = make_button("Fit to width", "100%");
    zoom_label_button.classList.add("pdf-viewer__zoom-label");
    const zoom_in_button = make_button("Zoom in", "+");
    zoom_group.append(zoom_out_button, zoom_label_button, zoom_in_button);

    bar.append(page_group, create_element("span", "pdf-viewer__divider"), zoom_group);

    // ---------- Scrolling document area ----------
    const scroll_area = create_element("div", "pdf-viewer__scroll", { tabIndex: 0 });
    scroll_area.setAttribute("aria-label", title);
    const pages_container = create_element("div", "pdf-pages");
    scroll_area.append(create_element("p", "pdf-viewer__status", { textContent: "Loading…" }));

    host.classList.add("pdf-viewer");
    host.removeAttribute("tabindex");
    host.replaceChildren(bar, scroll_area);

    let zoom_index = fit_zoom_index;
    let rendered_key = null;
    let render_token = 0;
    let is_fallback = false;

    const fit_width = () => {
      const style = getComputedStyle(scroll_area);
      return scroll_area.clientWidth - parseFloat(style.paddingLeft) - parseFloat(style.paddingRight);
    };

    const show_iframe_fallback = () => {
      is_fallback = true;
      page_group.hidden = true;
      zoom_group.hidden = true;
      const frame = create_element("iframe", "pdf-frame", { src: pdf_url, title });
      scroll_area.replaceChildren(frame);
    };

    // ---------- Page indicator ----------
    const page_elements = () => [...pages_container.children];

    const update_current_page = () => {
      const pages = page_elements();
      if (!pages.length || document.activeElement === page_input) return;
      const reading_line = scroll_area.getBoundingClientRect().top + scroll_area.clientHeight * 0.3;
      let current_page_number = 1;
      pages.forEach((page_element, index) => {
        if (page_element.getBoundingClientRect().top <= reading_line) current_page_number = index + 1;
      });
      page_input.value = String(current_page_number);
    };
    scroll_area.addEventListener("scroll", update_current_page, { passive: true });

    const go_to_page = () => {
      const pages = page_elements();
      const page_number = Math.min(pages.length, Math.max(1, parseInt(page_input.value, 10) || 1));
      page_input.value = String(page_number);
      if (!pages.length) return;
      scroll_area.scrollTo({
        top: pages[page_number - 1].offsetTop - parseFloat(getComputedStyle(scroll_area).paddingTop),
        behavior: "smooth",
      });
    };
    page_input.addEventListener("keydown", (event) => {
      if (event.key === "Enter") {
        go_to_page();
        page_input.blur();
      }
    });
    page_input.addEventListener("focus", () => page_input.select());
    page_input.addEventListener("blur", () => {
      go_to_page();
      update_current_page();
    });

    // ---------- Rendering ----------
    const render = async () => {
      if (is_fallback) return;
      if (!has_pdfjs) return show_iframe_fallback();
      const width = fit_width();
      if (width <= 0) return; // hidden (e.g. the other CV language): render when shown
      const zoom = zoom_levels[zoom_index];
      const render_key = `${width}@${zoom}`;
      if (render_key === rendered_key) return;
      rendered_key = render_key;
      const token = ++render_token;

      try {
        const pdf_document = await load_pdf(pdf_url);
        page_count_element.textContent = `/ ${pdf_document.numPages}`;
        const rendered_pages = [];
        for (let page_number = 1; page_number <= pdf_document.numPages; page_number++) {
          const page = await pdf_document.getPage(page_number);
          const fit_scale = width / page.getViewport({ scale: 1 }).width;
          rendered_pages.push(await render_page(page, fit_scale * zoom));
          if (token !== render_token) return; // a newer zoom/resize superseded this render
        }
        // Keep the reader's place: same relative scroll position before and after the swap.
        const vertical_ratio = scroll_area.scrollTop / Math.max(1, scroll_area.scrollHeight);
        const horizontal_ratio = scroll_area.scrollLeft / Math.max(1, scroll_area.scrollWidth);
        pages_container.replaceChildren(...rendered_pages);
        if (!pages_container.isConnected) scroll_area.replaceChildren(pages_container);
        scroll_area.scrollTop = vertical_ratio * scroll_area.scrollHeight;
        scroll_area.scrollLeft = horizontal_ratio * scroll_area.scrollWidth;
        update_current_page();
      } catch (error) {
        console.error("[pdf-viewer] PDF.js could not render", pdf_url, error);
        show_iframe_fallback();
      }
    };

    // ---------- Zoom ----------
    const set_zoom_index = (next_zoom_index) => {
      zoom_index = Math.min(zoom_levels.length - 1, Math.max(0, next_zoom_index));
      zoom_label_button.textContent = `${Math.round(zoom_levels[zoom_index] * 100)}%`;
      zoom_out_button.disabled = zoom_index === 0;
      zoom_in_button.disabled = zoom_index === zoom_levels.length - 1;
      render();
    };
    zoom_out_button.addEventListener("click", () => set_zoom_index(zoom_index - 1));
    zoom_label_button.addEventListener("click", () => set_zoom_index(fit_zoom_index));
    zoom_in_button.addEventListener("click", () => set_zoom_index(zoom_index + 1));

    let wheel_zoom_timer;
    let pending_wheel_steps = 0;
    scroll_area.addEventListener(
      "wheel",
      (event) => {
        if (!event.ctrlKey && !event.metaKey) return;
        event.preventDefault();
        pending_wheel_steps += event.deltaY < 0 ? 1 : -1;
        clearTimeout(wheel_zoom_timer);
        wheel_zoom_timer = setTimeout(() => {
          set_zoom_index(zoom_index + Math.sign(pending_wheel_steps));
          pending_wheel_steps = 0;
        }, 120);
      },
      { passive: false }
    );

    let resize_timer;
    window.addEventListener("resize", () => {
      clearTimeout(resize_timer);
      resize_timer = setTimeout(render, 200);
    });

    return { render };
  };
})();
