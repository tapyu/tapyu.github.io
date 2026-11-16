// Recommendation letters: LED navigation, panel snapping and reveals (as on the portfolio),
// with each letter's PDF rendered by PDF.js into a scrollable viewer (iframe fallback).
(() => {
  const scroll_behavior = "smooth";
  const letters = [...document.querySelectorAll(".letter")];

  // ---------- LED navigation (one LED per letter) ----------

  const led_nav_list = document.querySelector(".led-nav__list");
  const led_buttons = letters.map((letter) => {
    const list_item = document.createElement("li");
    const button = document.createElement("button");
    button.type = "button";
    button.className = "led-nav__button";
    button.title = letter.dataset.sectionLabel;
    button.setAttribute("aria-label", letter.dataset.sectionLabel);
    button.addEventListener("click", () => letter.scrollIntoView({ behavior: scroll_behavior }));
    list_item.append(button);
    led_nav_list.append(list_item);
    return button;
  });

  const set_active_letter = (active_index) => {
    letters.forEach((letter, letter_index) => {
      const is_active = letter_index === active_index;
      letter.classList.toggle("is-active", is_active);
      led_buttons[letter_index].classList.toggle("is-active", is_active);
      if (is_active) {
        led_buttons[letter_index].setAttribute("aria-current", "true");
      } else {
        led_buttons[letter_index].removeAttribute("aria-current");
      }
    });
  };

  const letter_observer = new IntersectionObserver(
    (entries) => {
      for (const entry of entries) {
        if (entry.isIntersecting) set_active_letter(letters.indexOf(entry.target));
      }
    },
    { rootMargin: "-50% 0px -50% 0px" }
  );
  letters.forEach((letter) => letter_observer.observe(letter));

  // ---------- PDF rendering ----------

  const has_pdfjs = Boolean(window.pdfjsLib);
  if (has_pdfjs) {
    pdfjsLib.GlobalWorkerOptions.workerSrc =
      "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js";
  }

  const pdf_documents = new Map(); // pdf url -> loading promise
  const rendered_widths = new Map(); // viewer -> width its pages were rendered at

  const load_pdf = (pdf_url) => {
    if (!pdf_documents.has(pdf_url)) pdf_documents.set(pdf_url, pdfjsLib.getDocument(pdf_url).promise);
    return pdf_documents.get(pdf_url);
  };

  const add_link_overlays = async (page, viewport, page_element) => {
    for (const annotation of await page.getAnnotations()) {
      if (annotation.subtype !== "Link" || !annotation.url) continue;
      const [left, top, right, bottom] = viewport.convertToViewportRectangle(annotation.rect);
      const link = document.createElement("a");
      link.className = "letter__page-link";
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

  const show_iframe_fallback = (letter, viewer) => {
    const frame = document.createElement("iframe");
    frame.className = "letter__frame";
    frame.src = letter.dataset.pdf;
    frame.title = viewer.getAttribute("aria-label");
    viewer.replaceChildren(frame);
  };

  const render_letter = async (letter) => {
    const viewer = letter.querySelector(".letter__viewer");
    const viewer_style = getComputedStyle(viewer);
    const content_width =
      viewer.clientWidth - parseFloat(viewer_style.paddingLeft) - parseFloat(viewer_style.paddingRight);
    if (rendered_widths.get(viewer) === content_width) return;
    rendered_widths.set(viewer, content_width);

    if (!has_pdfjs) {
      show_iframe_fallback(letter, viewer);
      return;
    }

    try {
      const pdf_document = await load_pdf(letter.dataset.pdf);
      const page_elements = [];
      for (let page_number = 1; page_number <= pdf_document.numPages; page_number++) {
        const page = await pdf_document.getPage(page_number);
        const css_viewport = page.getViewport({ scale: content_width / page.getViewport({ scale: 1 }).width });
        const pixel_ratio = Math.min(window.devicePixelRatio || 1, 3);
        const render_viewport = page.getViewport({ scale: css_viewport.scale * pixel_ratio });

        const canvas = document.createElement("canvas");
        canvas.className = "letter__page-canvas";
        canvas.width = Math.floor(render_viewport.width);
        canvas.height = Math.floor(render_viewport.height);
        await page.render({ canvasContext: canvas.getContext("2d"), viewport: render_viewport }).promise;

        const page_element = document.createElement("div");
        page_element.className = "letter__page";
        page_element.style.aspectRatio = `${css_viewport.width} / ${css_viewport.height}`;
        page_element.append(canvas);
        await add_link_overlays(page, css_viewport, page_element);
        page_elements.push(page_element);
      }
      // Swap all pages at once, so a re-render on resize never flashes empty.
      if (rendered_widths.get(viewer) === content_width) viewer.replaceChildren(...page_elements);
    } catch (error) {
      console.error("[letters] PDF.js could not render", letter.dataset.pdf, error);
      show_iframe_fallback(letter, viewer);
    }
  };

  letters.forEach(render_letter);

  let resize_timer;
  window.addEventListener("resize", () => {
    clearTimeout(resize_timer);
    resize_timer = setTimeout(() => letters.forEach(render_letter), 200);
  });

  // ---------- Scroll animations ----------

  const has_gsap = Boolean(window.gsap && window.ScrollTrigger);
  if (!has_gsap) return;

  gsap.registerPlugin(ScrollTrigger);

  // Snap to whole panels on wide screens; on phones a panel is taller than the
  // viewport, so snapping there would stop you from reaching the letter's end.
  ScrollTrigger.matchMedia({
    "(min-width: 901px)": () => {
      ScrollTrigger.create({
        trigger: ".letters",
        start: "top top",
        end: "bottom bottom",
        snap: {
          snapTo: (progress, self) => {
            const scroll_range = self.end - self.start;
            const letter_progresses = letters.map((letter) =>
              Math.min(1, (letter.getBoundingClientRect().top + window.scrollY - self.start) / scroll_range)
            );
            return letter_progresses.reduce((closest, candidate) =>
              Math.abs(candidate - progress) < Math.abs(closest - progress) ? candidate : closest
            );
          },
          duration: { min: 0.2, max: 0.6 },
          delay: 0.15,
          ease: "power1.inOut",
        },
      });
    },
  });

  // Copper trace that routes through the letters as you scroll.
  gsap.fromTo(
    ".projects__trace-fill",
    { scaleY: 0 },
    {
      scaleY: 1,
      ease: "none",
      scrollTrigger: { trigger: ".letters", start: "top top", end: "bottom bottom", scrub: true },
    }
  );

  // Each profile screen powers on, then the text and the letter slide in.
  for (const letter of letters) {
    gsap
      .timeline({
        scrollTrigger: { trigger: letter, start: "top 65%", toggleActions: "play none none reverse" },
      })
      .from(letter.querySelector(".letter__screen"), { y: 60, autoAlpha: 0, duration: 0.6, ease: "power2.out" })
      .fromTo(
        letter.querySelector(".letter__screen > *"),
        { clipPath: "inset(50% 0% 50% 0%)" },
        { clipPath: "inset(0% 0% 0% 0%)", duration: 0.5, ease: "power3.inOut" },
        0.35
      )
      .from(
        letter.querySelectorAll(".letter__profile > :not(.letter__screen)"),
        { y: 40, autoAlpha: 0, stagger: 0.07, duration: 0.6, ease: "power2.out" },
        0.15
      )
      .from(
        letter.querySelector(".letter__viewer"),
        { y: 50, autoAlpha: 0, duration: 0.7, ease: "power2.out" },
        0.25
      );
  }
})();
