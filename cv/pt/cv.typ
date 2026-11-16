#import "my_cv_template.typ": my_template, add_general_info, add_education, add_experience, add_research, add_thesis, add_journal_article, add_conference_proceedings, add_book_chapter, add_patent

// cv settings
#let color_theme = black
// personal information
#let info = (
  name: "Rubem Vasconcelos Pacelli",
  city_state_country: "Fortaleza, Ceará, Brasil",
  home_place: (
    full: "Universidade Federal do Ceará",
    initials: "UFC",
    url: "https://www.ufc.br/",
  ),
  program: (
    initials: "PPGETI",
    url: "https://ppgeti.ufc.br/",
  ),
  group: (
    initials: "GPSI",
    url: "https://ppgeti.ufc.br/en/laboratories/laboratory-of-the-signal-and-information-processing-research-group-gpsi/",
  )
)
// contact
#let contact = (
  cellphone: "+55 85 981824344",
  github: (
    url: "https://github.com/tapyu",
    fig: "figs/github.svg",
  ),
  email: (
    url: "mailto:rubem.engenharia@gmail.com",
    fig: "figs/email.png"
  ),
  linkedin: (
    url: "https://www.linkedin.com/in/rubem-pacelli/",
    fig: "figs/linkedin.svg",
  ),
  lattes: (
    url: "http://lattes.cnpq.br/0717252455115225",
    fig: "figs/lattes.png"
  ),
  scholar: (
    url: "https://scholar.google.com.br/citations?user=Kj6Gzs4AAAAJ&hl=pt-BR&oi=sra",
    fig: "figs/google scholar.png"
  ),
  orcid: (
    url: "https://orcid.org/0000-0001-5933-8565",
    fig: "figs/orcid.png"
  )
)
// education
#let education = (
  doctorate: (
    course: "Engenharia de Teleinformática",
    level: "Doutorado",
    initials: "Doutorado",
    start: "jul 2021",
    end: "atual",
    location: "Fortaleza, Brasil",
    university: (
      full: "Universidade Federal do Ceará",
      initials: "UFC",
    ),
    thesis: (
      kind: "Tese de doutorado",
      title: "Detection, characterization, and forecasting of the equatorial ionospheric scintillation signal on GNSS receive",
      advisors: (
        "Felix Dieter Antreich",
        "André Lima Ferrer de Almeida"
      ),
      is_pt: false,
    )
  ),
  master: (
    course: "Engenharia de Teleinformática",
    level: "Mestrado",
    initials: "Mestrado",
    start: "jan 2019",
    end: "jun 2021",
    location: "Fortaleza, Brasil",
    university: (
      full: "Universidade Federal do Ceará",
      initials: "UFC",
    ),
    thesis: (
      kind: "Dissertação de mestrado",
      title: "Modem AFSK coerente e completamente digital para o módulo de TT&C de sistemas CubeSat",
      advisors: (
        "João Cesar Moura Mota",
        "Antônio Macilio Pereira de Lucena"
      ),
      is_pt: true,
      url: "http://repositorio.ufc.br/bitstream/riufc/60259/1/2021_dis_rvpacelli.pdf"
    )
  ),
  graduation: (
    course: "Engenharia Eletrônica",
    level: "Graduação",
    initials: "Graduação",
    start: "jan 2013",
    end: "dez 2018",
    location: "Fortaleza, Brasil",
    university: (
      full: "Universidade de Fortaleza",
      initials: "Unifor"
    ),
    thesis: (
      kind: "Trabalho de conclusão de curso",
      title: "Projeto de um conversor carregador portátil com interface USB Tipo-C",
      advisors: ("Bruno Ricardo de Almeida",),
      is_pt: true,
    )
  ),
)
// experience
#let experience = (
  ird-ufc: (
    name: "Parceria de pesquisa IRD-UFC",
    university: "Universidade Federal do Ceará (UFC)",
    info: (
      "Pesquisa em aprendizado de máquina e processamento estatístico de sinais.",
      "Desenvolvimento de um projeto de pesquisa em colaboração com o IRD (Institut de Recherche pour le Développement, França)."
    ),
    location: "Fortaleza, Brasil",
    start: "jun 2019",
    end: "dez 2020"
  )
)
// research
#let research = (
  pr2019: (
    name: "Pesquisa e desenvolvimento de um modem completamente digital para comunicações via satélite",
    start: "jun 2019",
    end: "jun 2021",
    from: "Bolsa de mestrado da Coordenação de Aperfeiçoamento de Pessoal de Nível Superior (CAPES)",
    info: (
      "Modem completamente digital para comunicações via satélite, visando sua implementação em FPGAs.",
      "Projeto da arquitetura lógica do modulador e do demodulador.",
      "Desenvolvimento de módulos de sincronização para o atraso de temporização de símbolo e o desvio de fase."
    )
  ),
  pr2017: (
    name: "Demodulador GMSK não coerente para sistemas CubeSat",
    start: "fev 2017",
    end: "jan 2018",
    from: "Bolsa de iniciação científica do Conselho Nacional de Desenvolvimento Científico e Tecnológico (CNPq)",
    info: ("Desenvolvimento de um demodulador GMSK não coerente para sistemas CubeSat.",)
  ),
  pr2016: (
    name: "Sincronização em sistemas OFDM",
    start: "fev 2016",
    end: "jan 2017",
    from: "Bolsa de iniciação científica do Conselho Nacional de Desenvolvimento Científico e Tecnológico (CNPq)",
    info: ("Pesquisa sobre técnicas de sincronização aplicadas a sistemas OFDM.",)
  ),
  pr2015: (
    name: "Sincronização de sinais com múltiplas portadoras",
    start: "fev 2015",
    end: "jan 2016",
    from: "Bolsa de iniciação científica do Conselho Nacional de Desenvolvimento Científico e Tecnológico (CNPq)",
    info: ("Pesquisa sobre técnicas de sincronização aplicadas a sistemas com múltiplas portadoras.",)
  ),
)
// publications
#let publications = (
  jounal_articles: (
    bjd2020: (
      title: "Modem GMSK completamente digital com demodulação não-coerente",
      publisher: "Brazilian Journal of Development",
      volume: "6",
      issue_number: "4",
      start-page: "17988",
      end-page: "17996",
      year: 2020,
      url: "https://doi.org/10.34117/bjdv6n4-099",
      is_pt: true,
      authors: (
        "Pacelli, R. V.",
        "Lucena, A. M. P."
      )
    ),
    bjd2020a: (
      title: "Técnica de sincronização de portadora para sistemas de comunicação OFDM",
      publisher: "Brazilian Journal of Development",
      volume: "6",
      issue_number: "3",
      start-page: "14297",
      end-page: "14305",
      year: 2020,
      url: "https://doi.org/10.34117/bjdv6n3-338",
      is_pt: true,
      authors: (
        "Pacelli, R. V.",
        "Lucena, A. M. P."
      )
    ),
    bjd2020b: (
      title: "Técnica de seleção de portadoras para sistema OFDM em canais dispersivos no tempo",
      publisher: "Brazilian Journal of Development",
      volume: "6",
      // issue_number: "3",
      start-page: "14318",
      end-page: "14324",
      year: 2020,
      url: "https://doi.org/10.34117/bjdv6n3-340",
      is_pt: true,
      authors: (
        "Figueiredo, S. S.",
        "Lucena, A. M. P.",
        "Pacelli, R. V.",
      )
    ),
    rev_tec2019: (
      title: "Sistema OFDM com estimadores de frequência e de fase para sincronização de portadora",
      publisher: "Revista Tecnologia",
      volume: "40",
      issue_number: "1",
      start-page: "1",
      end-page: "16",
      year: 2019,
      url: "https://doi.org/10.5020/23180730.2019.7506",
      is_pt: true,
      authors: (
        "Pacelli, R. V.",
        "Lucena, A. M. P.",
      )
    )
  ),
  conferences: (
    cba2022: (
      title: "Convolutional Long-Short-Term Memory Networks (ConvLSTM) for Weather Prediction using Radar and Satellite Images",
      from: "CBA 2022",
      start-page: "1",
      end-page: "8",
      year: 2022,
      url: "https://www.sba.org.br/cba2022/wp-content/uploads/artigos_cba2022/paper_2351.pdf",
      is_pt: false,
      authors: (
        "Moreira, N. A.",
        "Pacelli, R. V.",
        "Silva, Y. C. B.",
        "Maciel, T. F.",
        "Simoes, I.",
        "Mota, J. C. M.",
        "Hamida, C.",
        "Prado, R. Z.",
        "Caillault, E.",
        "Kacou, M.",
        "Gosset, M.",
      )
    ),
    sbrt2020: (
      title: "All-digital AFSK modem with Viterbi detection for TT&C CubeSat transceiver",
      from: "XXXVIII Simpósio Brasileiro de Telecomunicações e Processamento De Sinais",
      start-page: "1",
      end-page: "5",
      year: 2022,
      url: "https://www.sbrt.org.br/sbrt2020/papers/1570654898.pdf",
      is_pt: false,
      authors: (
        "Pacelli, R. V.",
        "Mota, J. C. M.",
        "Lucena, A. M. P.",
      )
    ),
    ic_unifor2016: (
      title: "Uma técnica para sincronização de frequência na modulação OFDM",
      from: "XXII Encontro de Iniciação à Pesquisa",
      start-page: "1",
      end-page: "5",
      year: 2016,
      url: "https://uol.unifor.br/oul/conteudosite/?cdConteudo=6946081",
      is_pt: true,
      authors: (
        "Mourão, J. A",
        "Pacelli, R. V.",
        "Lucena, A. M. P.",
      )
    )
  ),
  book_chapter: (
    uncertainties2023: (
      title: "A Data-Based Estimation of Power-Law Coefficients for Rainfall via Levenberg-Marquardt Algorithm: Results from the West African Testbed",
      publisher: "Springer Cham",
      book: "Proceedings of the 6th International Symposium on Uncertainty Quantification and Stochastic Modelling",
      chapter: "20",
      // volume: "1",
      start-page: "190",
      end-page: "201",
      year: 2023,
      url: "https://doi.org/10.1007/978-3-031-47036-3_17",
      is_pt: false,
      authors: (
        "Pacelli, R. V.",
        "Moreira, N. de A.",
        "Maciel, T. F.",
        "Kacou, M.",
        "Gosset, M.",
      )
    ),
    atena2021: (
      title: "Sincronização do tempo de símbolo em sistemas OFDM",
      publisher: "Atena",
      book: "Ciências Exatas e da Terra: Exploração e Qualificação de Diferentes Tecnologias",
      chapter: "18",
      volume: "4",
      start-page: "200",
      end-page: "207",
      year: 2021,
      url: "https://doi.org/10.22533/at.ed.13021130118",
      is_pt: true,
      authors: (
        "Pacelli, R. V.",
        "Lucena, A. M. P.",
        "Araújo, D. C.",
        "Mourão, J. A",
      )
    ),
    bj2020: (
      title: "Sistema GMSK com demodulação não-coerente e implementação completamente digital",
      publisher: "Atena",
      book: "Os impactos de estudos voltados para as ciências exatas",
      chapter: "2",
      volume: "1",
      start-page: "21",
      end-page: "30",
      year: 2020,
      url: "https://doi.org/10.35587/brj.ed.0000587",
      is_pt: true,
      authors: (
        "Pacelli, R. V.",
        "Lucena, A. M. P.",
      )
    ),
  )
)
// patents
#let patents = (
  BR_10_2021_023220_0: (
    requirement: "BR 10 2021 023220 0",
    title: "Arquitetura de demodulação digital e método de detecção coerente para sinais AFSK",
    is_pt: true,
    status: "depositada"
  )
)

#show: my_doc => my_template(info.name, color_theme,  my_doc)

= Informações Gerais
#add_general_info((
  info.city_state_country,
  [Última atualização: #datetime.today().display("[day]/[month]/[year]")],
  [#info.home_place.full (#info.home_place.initials)],
  [Celular: #contact.cellphone],
  [#link(info.home_place.url)[#info.home_place.initials]-#link(info.program.url)[#info.program.initials]-#link(info.group.url)[#info.group.initials]],
  [
    #link(contact.email.url)[#box(image(contact.email.fig, height: 10pt))],
    #link(contact.orcid.url)[#box(image(contact.orcid.fig, height: 10pt))],
    #link(contact.lattes.url)[#box(image(contact.lattes.fig, height: 10pt))],
    #link(contact.github.url)[#box(image(contact.github.fig, height: 10pt))],
    #link(contact.scholar.url)[#box(image(contact.scholar.fig, height: 10pt))],
    #link(contact.linkedin.url)[#box(image(contact.linkedin.fig, height: 10pt))]
  ]
))

= Resumo Profissional

Engenheiro com experiência acadêmica em processamento de sinais GNSS e formação multidisciplinar em
- Processamento estatístico de sinais, identificação de sistemas e filtragem adaptativa.
- Rádio definido por software, modems digitais e técnicas de sincronização.
- Aprendizado profundo, reconhecimento de padrões e teoria de otimização.

= Formação Acadêmica
#add_education(education.graduation)
#add_education(education.master)
#add_education(education.doctorate)

= Experiência
#{
  set enum(numbering: "E1")
  for exp in experience {
    [+ #add_experience(exp.at(1))]
  }
}

= Projetos e Financiamento de Pesquisa
#{
  set enum(numbering: "Pr1")
  for res in research {
    [+ #add_research(res.at(1))]
  }
}

= Competências

== Técnicas
- Linguagens de programação científica: Python, Julia, R, MATLAB/Simulink, Octave.
- Frameworks de aprendizado profundo: PyTorch, TensorFlow, Keras.
- Ferramentas de MLOps:
  - Ecossistema Amazon Web Services (AWS): Amazon SageMaker, Elastic Container Service (ECS), Elastic Container Registry (ECR).
  - Pipelines de CI/CD: Jenkins, GitHub Actions, Travis CI.
  - Tecnologias de contêineres: Docker, Kubernetes.
  - Data Version Control (DVC).
- Linguagens de programação de sistemas: C, C++ e Assembly.
- GNU/Linux: scripts em shell UNIX, fundamentos de sistemas Linux, git.
- Sistemas de composição tipográfica: LaTeX, Typst.

== Idiomas
- Inglês: proficiência profissional (exames #link("https://github.com/tapyu/tapyu/blob/master/cv/Latex/figs/Toefl.pdf")[TOEFL iBT] e #link("https://github.com/tapyu/tapyu/blob/master/cv/Latex/figs/Cambridge\%20FCE.pdf")[Cambridge FCE]).
- Português: língua materna.

= Docência e Apoio

- Atuei como professor assistente de Comunicações Digitais na #education.doctorate.university.initials durante o doutorado em #education.doctorate.course.
- Atuei como professor assistente de Processamento Digital de Sinais na #education.master.university.initials durante o mestrado em #education.master.course.
- Atuei como professor assistente de Teoria de Controle na #education.graduation.university.initials durante a graduação em #education.graduation.course.

= Atividade Acadêmica e Afiliações
== Membro associado
- Sociedade Brasileira de Telecomunicações (SBrT)

= Publicações
Minhas publicações acadêmicas também estão listadas no #link(contact.scholar.url)[Google Scholar].

== Teses e Dissertações

#for (_, edu) in education [
  - #add_thesis(edu)
]

== Artigos em Periódicos
#{
  set enum(numbering: "P1")
  for (_, article) in publications.jounal_articles [
    + #add_journal_article(article)
  ]
}

== Artigos em Anais de Congressos
#{
  set enum(numbering: "C1")
  for (_, article) in publications.conferences [
    + #add_conference_proceedings(article)
  ]
}

== Capítulos de Livros
#{
  set enum(numbering: "CL1")
  for (_, chapter) in publications.book_chapter [
    + #add_book_chapter(chapter)
  ]
}

= Patentes
#for (_, patent) in patents {
  add_patent(patent)
}
