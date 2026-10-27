// Portfolio page: LED section navigation, scroll-driven workbench parallax and project reveals.
(() => {
  const is_reduced_motion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  const scroll_behavior = is_reduced_motion ? "auto" : "smooth";

  // ---------- LED navigation (one LED per [data-section]) ----------

  const sections = [...document.querySelectorAll("[data-section]")];
  const led_nav_list = document.querySelector(".led-nav__list");

  const led_buttons = sections.map((section) => {
    const list_item = document.createElement("li");
    const button = document.createElement("button");
    button.type = "button";
    button.className = "led-nav__button";
    button.title = section.dataset.sectionLabel;
    button.setAttribute("aria-label", section.dataset.sectionLabel);
    button.addEventListener("click", () => section.scrollIntoView({ behavior: scroll_behavior }));
    list_item.append(button);
    led_nav_list.append(list_item);
    return button;
  });

  const set_active_section = (active_index) => {
    sections.forEach((section, section_index) => {
      const is_active = section_index === active_index;
      section.classList.toggle("is-active", is_active);
      led_buttons[section_index].classList.toggle("is-active", is_active);
      if (is_active) {
        led_buttons[section_index].setAttribute("aria-current", "true");
      } else {
        led_buttons[section_index].removeAttribute("aria-current");
      }
    });
  };

  // A section is active while it crosses the vertical middle of the viewport.
  const section_observer = new IntersectionObserver(
    (entries) => {
      for (const entry of entries) {
        if (entry.isIntersecting) set_active_section(sections.indexOf(entry.target));
      }
    },
    { rootMargin: "-50% 0px -50% 0px" }
  );
  sections.forEach((section) => section_observer.observe(section));

  // The PCB curtain gets a new revision every year: "REV YYYY".
  document.querySelector(".pcb-revision-year").textContent = new Date().getFullYear();

  document.querySelector(".hero__cue").addEventListener("click", () => {
    document.querySelector(".project").scrollIntoView({ behavior: scroll_behavior });
  });

  // ---------- Scroll animations ----------
  // They are driven by the user's own scrolling, so they also run with reduced motion;
  // only the looping ambient animations are disabled in that case (see portfolio.css).

  const has_gsap = Boolean(window.gsap && window.ScrollTrigger);
  if (!has_gsap) return;

  gsap.registerPlugin(ScrollTrigger);

  // Parallax: each layer rises at its own speed (y in SVG viewBox units); the PCB ends up covering the scene.
  gsap
    .timeline({
      defaults: { ease: "none" },
      scrollTrigger: {
        trigger: ".hero",
        start: "top top",
        end: "bottom bottom",
        scrub: 1,
        invalidateOnRefresh: true,
      },
    })
    .to(".scene-layer--wall .scene-layer__content", { y: -150 }, 0)
    .to(".scene-layer--instruments .scene-layer__content", { y: -260 }, 0)
    .to(".hero__heading", { y: () => -window.innerHeight * 0.1 }, 0)
    .to([".hero__kicker", ".hero__cue"], { autoAlpha: 0, duration: 0.1 }, 0)
    .to(".scene-layer--desk .scene-layer__content", { y: -450 }, 0)
    .to(".scene-layer--foreground .scene-layer__content", { y: -1000 }, 0);

  // fullPage-style snapping: once past the workbench, scrolling settles on the nearest panel.
  const snap_panels = [...document.querySelectorAll(".project, .outro")];
  ScrollTrigger.create({
    trigger: ".projects",
    start: "top top",
    end: "bottom bottom",
    snap: {
      snapTo: (progress, self) => {
        const scroll_range = self.end - self.start;
        const panel_progresses = snap_panels.map((panel) =>
          Math.min(1, (panel.getBoundingClientRect().top + window.scrollY - self.start) / scroll_range)
        );
        return panel_progresses.reduce((closest, candidate) =>
          Math.abs(candidate - progress) < Math.abs(closest - progress) ? candidate : closest
        );
      },
      duration: { min: 0.2, max: 0.6 },
      delay: 0.15,
      ease: "power1.inOut",
    },
  });

  // Copper trace that "routes" through the projects as you scroll.
  gsap.fromTo(
    ".projects__trace-fill",
    { scaleY: 0 },
    {
      scaleY: 1,
      ease: "none",
      scrollTrigger: { trigger: ".projects", start: "top 50%", end: "bottom 50%", scrub: true },
    }
  );

  // Each project powers on like a scope screen, then its text slides in.
  for (const project of document.querySelectorAll(".project")) {
    gsap
      .timeline({
        scrollTrigger: { trigger: project, start: "top 65%", toggleActions: "play none none reverse" },
      })
      .from(project.querySelector(".project__screen"), { y: 60, autoAlpha: 0, duration: 0.6, ease: "power2.out" })
      .fromTo(
        project.querySelector(".project__screen > *"),
        { clipPath: "inset(50% 0% 50% 0%)" },
        { clipPath: "inset(0% 0% 0% 0%)", duration: 0.5, ease: "power3.inOut" },
        0.35
      )
      .from(
        project.querySelectorAll(".project__body > *"),
        { y: 40, autoAlpha: 0, stagger: 0.07, duration: 0.6, ease: "power2.out" },
        0.15
      );
  }
})();
