// CV page: English/Portuguese sub-tabs, each rendering its PDF with PDF.js
// (page canvases plus clickable link overlays), falling back to an <iframe>.
(() => {
  const tabs = [...document.querySelectorAll(".cv__switch-tab")];
  const panels = [...document.querySelectorAll(".cv__panel")];
  const switch_indicator = document.querySelector(".cv__switch-indicator");

  const has_pdfjs = Boolean(window.pdfjsLib);
  if (has_pdfjs) {
    pdfjsLib.GlobalWorkerOptions.workerSrc =
      "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js";
  }

  // ---------- Rendering ----------

  const pdf_documents = new Map(); // pdf url -> loading promise
  const rendered_widths = new Map(); // panel -> width its pages were rendered at

  const load_pdf = (pdf_url) => {
    if (!pdf_documents.has(pdf_url)) {
      pdf_documents.set(pdf_url, pdfjsLib.getDocument(pdf_url).promise);
    }
    return pdf_documents.get(pdf_url);
  };

  const add_link_overlays = async (page, viewport, page_element) => {
    const annotations = await page.getAnnotations();
    for (const annotation of annotations) {
      if (annotation.subtype !== "Link" || !annotation.url) continue;
      const [left, top, right, bottom] = viewport.convertToViewportRectangle(annotation.rect);
      const link = document.createElement("a");
      link.className = "cv__page-link";
      link.href = annotation.url;
      link.target = "_blank";
      link.rel = "noopener";
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

  const show_iframe_fallback = (panel) => {
    const pages_container = panel.querySelector(".cv__pages");
    const frame = document.createElement("iframe");
    frame.className = "cv__frame";
    frame.src = panel.dataset.pdf;
    frame.title = panel.querySelector(".cv__action").textContent;
    pages_container.replaceChildren(frame);
  };

  const render_panel = async (panel) => {
    const pages_container = panel.querySelector(".cv__pages");
    const container_width = pages_container.clientWidth;
    if (rendered_widths.get(panel) === container_width) return;
    rendered_widths.set(panel, container_width);

    if (!has_pdfjs) {
      show_iframe_fallback(panel);
      return;
    }

    try {
      const pdf_document = await load_pdf(panel.dataset.pdf);
      const page_elements = [];
      for (let page_number = 1; page_number <= pdf_document.numPages; page_number++) {
        const page = await pdf_document.getPage(page_number);
        const css_viewport = page.getViewport({ scale: container_width / page.getViewport({ scale: 1 }).width });
        const pixel_ratio = Math.min(window.devicePixelRatio || 1, 3);
        const render_viewport = page.getViewport({ scale: css_viewport.scale * pixel_ratio });

        const canvas = document.createElement("canvas");
        canvas.className = "cv__page-canvas";
        canvas.width = Math.floor(render_viewport.width);
        canvas.height = Math.floor(render_viewport.height);
        await page.render({ canvasContext: canvas.getContext("2d"), viewport: render_viewport }).promise;

        const page_element = document.createElement("div");
        page_element.className = "cv__page";
        page_element.style.aspectRatio = `${css_viewport.width} / ${css_viewport.height}`;
        page_element.append(canvas);
        await add_link_overlays(page, css_viewport, page_element);
        page_elements.push(page_element);
      }
      // Swap all pages at once, so a re-render on resize never flashes empty.
      if (rendered_widths.get(panel) === container_width) pages_container.replaceChildren(...page_elements);
    } catch (error) {
      console.error("[cv] PDF.js could not render", panel.dataset.pdf, error);
      show_iframe_fallback(panel);
    }
  };

  // ---------- Sub-tabs ----------

  const move_indicator = (active_tab) => {
    switch_indicator.style.width = `${active_tab.offsetWidth}px`;
    switch_indicator.style.transform = `translateX(${active_tab.offsetLeft}px)`;
  };

  const activate_language = (language, { should_focus = false } = {}) => {
    const active_tab = tabs.find((tab) => tab.dataset.language === language) ?? tabs[0];
    for (const tab of tabs) {
      const is_active = tab === active_tab;
      tab.setAttribute("aria-selected", String(is_active));
      tab.tabIndex = is_active ? 0 : -1;
    }
    for (const panel of panels) {
      panel.hidden = panel.dataset.language !== active_tab.dataset.language;
      if (!panel.hidden) render_panel(panel);
    }
    move_indicator(active_tab);
    if (should_focus) active_tab.focus();
    history.replaceState(null, "", `#${active_tab.dataset.language}`);
  };

  for (const tab of tabs) {
    tab.addEventListener("click", () => activate_language(tab.dataset.language));
    // Arrow keys move between the two languages (WAI-ARIA tabs pattern).
    tab.addEventListener("keydown", (event) => {
      if (event.key !== "ArrowLeft" && event.key !== "ArrowRight") return;
      event.preventDefault();
      const next_index = (tabs.indexOf(tab) + (event.key === "ArrowRight" ? 1 : -1) + tabs.length) % tabs.length;
      activate_language(tabs[next_index].dataset.language, { should_focus: true });
    });
  }

  const initial_language = location.hash === "#pt" ? "pt" : "en";
  activate_language(initial_language);
  // The indicator should only glide on user clicks, not on page load.
  requestAnimationFrame(() => switch_indicator.classList.add("is-ready"));

  // Re-render sharper/smaller pages when the column width changes.
  let resize_timer;
  window.addEventListener("resize", () => {
    clearTimeout(resize_timer);
    resize_timer = setTimeout(() => {
      move_indicator(tabs.find((tab) => tab.getAttribute("aria-selected") === "true"));
      const visible_panel = panels.find((panel) => !panel.hidden);
      if (visible_panel) render_panel(visible_panel);
    }, 200);
  });
})();
