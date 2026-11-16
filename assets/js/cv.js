// CV page: English/Portuguese sub-tabs, each showing its PDF in the shared viewer
// (assets/js/pdf-viewer.js: zoom, selectable text, clickable links, iframe fallback).
(() => {
  const tabs = [...document.querySelectorAll(".cv__switch-tab")];
  const panels = [...document.querySelectorAll(".cv__panel")];
  const switch_indicator = document.querySelector(".cv__switch-indicator");

  // One viewer per language (its bar carries the page indicator and zoom).
  const viewers = new Map(
    panels.map((panel) => [
      panel,
      window.create_pdf_viewer({
        host: panel.querySelector(".cv__pages"),
        pdf_url: panel.dataset.pdf,
        title: panel.dataset.language === "pt" ? "Currículo · Português" : "Curriculum Vitae · English",
      }),
    ])
  );

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
      // a hidden panel has no width; it renders the first time it is shown
      if (!panel.hidden) viewers.get(panel).render();
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

  window.addEventListener("resize", () =>
    move_indicator(tabs.find((tab) => tab.getAttribute("aria-selected") === "true"))
  );
})();
