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

  // ---------- PDF viewers (assets/js/pdf-viewer.js: zoom, text selection, links) ----------

  for (const letter of letters) {
    const viewer = letter.querySelector(".letter__viewer");
    window
      .create_pdf_viewer({
        host: viewer,
        pdf_url: letter.dataset.pdf,
        title: viewer.getAttribute("aria-label"),
      })
      .render();
  }

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
        letter.querySelector(".letter__document"),
        { y: 50, autoAlpha: 0, duration: 0.7, ease: "power2.out" },
        0.25
      );
  }
})();
