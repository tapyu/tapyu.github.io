// Links page: contribution-graph backdrop and pointer spotlight on the featured GitHub card.
(() => {
  const featured_link = document.querySelector(".featured-link");
  const contribution_graph = document.querySelector(".featured-link__graph");
  if (!featured_link || !contribution_graph) return;

  // ---------- Contribution graph (7 days x N weeks, like a GitHub profile) ----------

  const day_count = 7;
  const week_count = 30;

  // Seeded pseudo-random levels, so the pattern is identical on every visit.
  let random_seed = 20240211;
  const next_random = () => {
    random_seed = (random_seed * 16807) % 2147483647;
    return random_seed / 2147483647;
  };

  const cells = document.createDocumentFragment();
  for (let week_index = 0; week_index < week_count; week_index++) {
    // Recent weeks (on the right) are busier.
    const recency = week_index / (week_count - 1);
    for (let day_index = 0; day_index < day_count; day_index++) {
      const activity = next_random() * (0.35 + 0.75 * recency);
      const cell = document.createElement("span");
      cell.className = "featured-link__cell";
      cell.dataset.level = String(Math.min(4, Math.floor(activity * 5)));
      cell.style.setProperty("--week-index", week_index);
      cells.append(cell);
    }
  }
  contribution_graph.append(cells);

  // ---------- Spotlight that follows the pointer ----------

  const has_fine_pointer = window.matchMedia("(hover: hover) and (pointer: fine)").matches;
  if (!has_fine_pointer) return;

  // A dedicated element, so moving it does not restyle the 200+ graph cells.
  const spotlight = document.createElement("span");
  spotlight.className = "featured-link__spotlight";
  spotlight.setAttribute("aria-hidden", "true");
  featured_link.prepend(spotlight);

  featured_link.addEventListener("pointermove", (event) => {
    const card_bounds = featured_link.getBoundingClientRect();
    spotlight.style.transform = `translate(${event.clientX - card_bounds.left}px, ${event.clientY - card_bounds.top}px)`;
  });
})();
