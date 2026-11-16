#let my_template(name, color, rest) = {
  set text(
    12pt,
    font: "New Computer Modern",
  )
  set page(margin: 40pt)
  set par(justify: true, leading: 0.5em)

  align(center)[#smallcaps(text(size: 2.5em, fill: color)[#name])]

  show heading.where(level: 1): i => {
    set align(left)

    set block(above: 1em)
      set text(weight: "light", size: 1.2em, fill: black)
      stack(
        dir: ttb,
        spacing: 2mm,
        smallcaps(i.body),
        line(length: 100%, stroke: black + 2pt)
    )
  }
  rest
}

// General CV entry that is split into a left and right half
#let cv_entry(entries, left-space: 1fr, right-space: 1fr) = {
  let entries_aligned = ()
  let count = 1
  for entry in (entries) {
    if int(count/2) == count/2 {
      entries_aligned.push({
        align(right)[
          #entry
        ]
      })
    } else {
      entries_aligned.push({
        align(left)[
          #entry
        ]
      })
    }
    count += 1
  }
  grid(
    columns: (left-space, right-space),
    row-gutter: 6pt,
    ..entries_aligned,
  )
}

#let add_general_info(general_info) = {
  cv_entry(general_info, left-space: 2fr, right-space: 3fr)
}

#let add_education(education) = {
  cv_entry((
    [*#education.initials* in #education.course],
    [#education.start\-#education.end],
    [#education.university.full (#education.university.initials)],
    education.location
  ))
  if education.keys().contains("cotutelle") {
    let cot = education.cotutelle
    cv_entry((
      [*#cot.initials* in #cot.course (cotutelle)],
      [#cot.start\-#cot.end],
      [#cot.university.full (#cot.university.initials)],
      cot.location
    ), left-space: 3fr, right-space: 1fr)
  }
}

#let add_experience(experience) = {
  cv_entry((
    experience.name,
    [#experience.start\-#experience.end],
    experience.university,
    experience.location
  ))

  for info in experience.info [
    - #info
  ]
}

#let add_research(research) = {
  cv_entry((
    research.name,
    [#research.start\-#research.end],
  ), left-space: 3fr, right-space: 2fr)
  text(10pt)[#research.from]
  for info in research.info [
    - #info
  ]
}

#let advisors_text(advisors) = advisors.map(a => [Prof. Dr. #a]).join([ and ])

#let add_thesis(edu) = {
  let cot = edu.at("cotutelle", default: none)
  [#edu.level's thesis in #edu.course#if cot != none [ (#edu.university.initials) and #cot.course (#cot.university.initials), under a cotutelle agreement]. "#if edu.thesis.keys().contains("url") {link(edu.thesis.url)[#edu.thesis.title]} else {edu.thesis.title}"#if edu.thesis.is_pt [ (in Portuguese)]. Advised by #advisors_text(edu.thesis.advisors)#if cot != none [ (#edu.university.initials), and #advisors_text(cot.advisors) (#cot.university.initials)].]
}

#let add_journal_article(article) = {
  for (index, author) in article.authors.enumerate() {
    author
    if index+1 < article.authors.len() [, ] else [.]
  }
  if article.keys().contains("url"){
    link(article.url)["#article.title"]
  } else [
    "#article.title"
  ]
  if article.is_pt [
    (in Portuguese).
  ] else [.]
  if article.keys().contains("publisher") [
    #article.publisher,
  ]
  if article.keys().contains("volume") [
    vol. #article.volume,
  ]
  if article.keys().contains("issue_number") [
    n. #article.issue_number,
  ]
  if article.keys().contains("start-page") and article.keys().contains("end-page") [
    p. #article.start-page\-#article.end-page,
  ] else if article.keys().contains("start-page") [
    p. #article.start-page,
  ]
  if article.keys().contains("year") [
    #article.year.
  ]
}

#let add_conference_proceedings(article) = {
  for (index, author) in article.authors.enumerate() {
    author
    if index+1 < article.authors.len() [, ] else [.]
  }
  if article.keys().contains("url"){
    link(article.url)["#article.title"]
  } else [
    "#article.title"
  ]
  if article.is_pt [
    (in Portuguese).
  ] else [.]
  if article.keys().contains("from") [
    #article.from,
  ]
  if article.keys().contains("start-page") and article.keys().contains("end-page") [
    p. #article.start-page\-#article.end-page,
  ] else if article.keys().contains("start-page") [
    p. #article.start-page,
  ]
  if article.keys().contains("year") [
    #article.year.
  ]
}

#let add_book_chapter(article) = {
  for (index, author) in article.authors.enumerate() {
    author
    if index+1 < article.authors.len() [, ] else [.]
  }
  if article.keys().contains("url"){
    link(article.url)["#article.title"]
  } else [
    "#article.title"
  ]
  if article.is_pt [
    (in Portuguese).
  ] else [.]
  [Chapter #article.chapter in #article.book,]
  if article.keys().contains("start-page") and article.keys().contains("end-page") [
    p. #article.start-page\-#article.end-page,
  ] else if article.keys().contains("start-page") [
    p. #article.start-page,
  ]
  if article.keys().contains("year") [
    #article.year.
  ]
}

#let add_patent(patent) = [
  == #patent.requirement
  - #patent.title #if patent.is_pt [ (in Portuguese)].
  - Status: #patent.status.
]