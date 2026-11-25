#import "my_cv_template.typ": my_template, add_general_info, add_education, add_experience, add_research, add_thesis, add_journal_article, add_conference_proceedings, add_book_chapter, add_patent

// cv settings
#let color_theme = black
// personal information
#let info = (
  name: "Rubem Vasconcelos Pacelli",
  city_state_country: "Fortaleza, Ceará, Brazil",
  home_place: (
    full: "Federal University of Ceará",
    initials: "UFC",
    url: "https://www.ufc.br/",
  ),
  program: (
    initials: "PPGETI",
    url: "https://ppgeti.ufc.br/en/",
  ),
  second_place: (
    initials: "ITA",
    url: "https://www.ita.br/",
  ),
  second_program: (
    initials: "PGEEC",
    url: "https://www.ita.br/",
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
  ),
  website: (
    url: "https://tapyu.github.io/",
    fig: "figs/website.svg"
  )
)
// education
#let education = (
  doctorate: (
    course: "Teleinformatics Engineering",
    level: "Doctorate",
    initials: "PhD",
    start: "Jul 2021",
    end: "Apr 2026",
    location: "Fortaleza, Brazil",
    university: (
      full: "Federal University of Ceará",
      initials: "UFC",
    ),
    cotutelle: (
      course: "Aerospace Science and Technology",
      initials: "PhD",
      start: "2023",
      end: "Apr 2026",
      location: "Barcelona, Spain",
      university: (
        full: "Universitat Politècnica de Catalunya",
        initials: "UPC",
      ),
      advisors: (
        "Àngela Aragón Àngel",
        "Felix Dieter Antreich"
      ),
    ),
    thesis: (
      title: "Detection and characterization of equatorial ionospheric scintillation based on GNSS observations using convolutional neural networks",
      advisors: (
        "Felix Dieter Antreich",
        "André Lima Férrer de Almeida"
      ),
      is_pt: false,
    )
  ),
  master: (
    course: "Teleinformatics Engineering",
    level: "Master",
    initials: "Msc",
    start: "Jan 2019",
    end: "Jun 2021",
    location: "Fortaleza, Brazil",
    university: (
      full: "Federal University of Ceará",
      initials: "UFC",
    ),
    thesis: (
      title: "Coherent and all-digital AFSK modem for CubeSat-standard TT&C module",
      advisors: (
        "João Cesar Moura Mota",
        "Antônio Macilio Pereira de Lucena"
      ),
      is_pt: true,
      url: "http://repositorio.ufc.br/bitstream/riufc/60259/1/2021_dis_rvpacelli.pdf"
    )
  ),
  graduation: (
    course: "Electronics Engineering",
    level: "Graduation",
    initials: "BSc",
    start: "Aug 2014",
    end: "Dec 2018",
    location: "Fortaleza, Brazil",
    university: (
      full: "University of Fortaleza",
      initials: "Unifor"
    ),
    thesis: (
      title: "Design of a converter for a portable charger with USB Type-C interface",
      advisors: ("Bruno Ricardo de Almeida",),
      is_pt: true,
    )
  ),
)
// experience
#let experience = (
  ita2026: (
    name: "Postdoctoral researcher",
    university: "Aeronautics Institute of Technology (ITA)",
    info: (
      "Postdoctoral researcher in the Telecommunications area of the Graduate Program in Electronics and Computer Engineering (PGEEC), supervised by Prof. Dr. Felix Dieter Antreich.",
      "Research scholarship from the Casimiro Montenegro Filho Foundation (FCMF) in the project \"Study of Artificial Intelligence (AI) techniques applied to different telecommunications environments\", funded by ANATEL."
    ),
    location: "São José dos Campos, Brazil",
    start: "Apr 2026",
    end: "Present"
  ),
  ufc2026: (
    name: "Postdoctoral researcher",
    university: "Federal University of Ceará (UFC)",
    info: (
      "Postdoctoral researcher in the Graduate Program in Teleinformatics Engineering (PPGETI), supervised by Prof. Dr. André Lima Férrer de Almeida, with a CNPq scholarship.",
      "Research project on ionospheric scintillation effects on the GNSS signal processing chain, using hardware-in-the-loop simulation for realistic validation of the tracking module."
    ),
    location: "Fortaleza, Brazil",
    start: "Apr 2026",
    end: "Present"
  ),
  ird-ufc: (
    name: "IRD-UFC research partnership",
    university: "Federal University of Ceará (UFC)",
    info: (
      "Research on Machine Learning and Statistical Signal Processing.",
      "Developed a research project in collaboration with the IRD (Research Institute Pour Le Développement, France)."
    ),
    location: "Fortaleza, Brazil",
    start: "Jun 2019",
    end: "Dec 2020"
  ),
  armtec2017: (
    name: "Hardware intern",
    university: "Armtec Tecnologia em Robótica (ARMTEC)",
    info: (
      "Electronic circuit design and PCB layout with Altium.",
      "Participation in product development, from the requirements phase to assembly and testing."
    ),
    location: "Brazil",
    start: "2017",
    end: "2017"
  )
)
// research
#let research = (
  ufc_hil2026: (
    name: "Effects of ionospheric scintillation on the GNSS signal processing chain: hardware-in-the-loop (HIL) simulation for realistic validation of the tracking module",
    start: "2026",
    end: "Present",
    from: "Postdoctoral scholarship from National Council of Scientific and Technological Development (CNPq)",
    info: (
      "Investigation of ionospheric scintillation effects along the GNSS signal processing chain, focusing on the tracking module.",
      "Development of a hardware-in-the-loop platform that reproduces realistic scintillation conditions in a controlled and repeatable way to validate tracking algorithms."
    )
  ),
  anatel2024: (
    name: "Study of Artificial Intelligence (AI) techniques applied to different telecommunications environments",
    start: "2024",
    end: "Present",
    from: "Aeronautics Institute of Technology (ITA) project funded by the Casimiro Montenegro Filho Foundation (FCMF)",
    info: (
      "Application of AI and machine learning to telecommunications: service quality estimation, QoS versus infrastructure capacity, cybersecurity, autonomous spectrum monitoring, marketplace monitoring, and social-network detection of service outages.",
    )
  ),
  inct2024: (
    name: "INCT Signals: Airborne and Spaceborne Remote Sensing and Surveillance",
    start: "2024",
    end: "Present",
    from: "National Institute of Science and Technology (INCT) funded by multiple agencies",
    info: (
      "Research network (UFC, ITA, UFRGS, PUCRS, UNIPAMPA) developing remote sensing, communication, monitoring, and surveillance solutions from airborne and satellite platforms.",
    )
  ),
  pr2019: (
    name: "Research and development of a fully digital modem for satellite communications",
    start: "Jun 2019",
    end: "Jun 2021",
    from: "Master scholarship from Ceará Foundation for Support of Scientific and Technological Development (FUNCAP)",
    info: (
      "Fully digital modem for satellite communications, targeting its implementation in FPGAs.",
      "Design of the logical architecture of the modulator and demodulator.",
      "Development of synchronization modules for the symbol timing delay and phase offset."
    )
  ),
  pr2017: (
    name: "Noncoherent GMSK demodulator for CubeSat systems",
    start: "Feb 2017",
    end: "Jan 2018",
    from: "Scientific initiation scholarship from National Council of Scientific and Technological Development (CNPq)",
    info: ("Development of noncoherent GMSK demodulator for CubeSat systems.",)
  ),
  pr2016: (
    name: "Synchronization in OFDM systems",
    start: "Feb 2016",
    end: "Jan 2017",
    from: "Scientific initiation scholarship from National Council of Scientific and Technological Development (CNPq)",
    info: ("Research on synchronization techiniques applied to OFDM systems.",)
  ),
  pr2015: (
    name: "Synchronization of signals with multicarrier",
    start: "Feb 2015",
    end: "Jan 2016",
    from: "Scientific initiation scholarship from National Council of Scientific and Technological Development (CNPq)",
    info: ("Research on synchronization techniques applied to multicarrier systems.",)
  ),
)
// publications
#let publications = (
  jounal_articles: (
    taes2026: (
      title: "Machine Learning-Based Ionospheric Irregularity Parameter Estimation",
      publisher: "IEEE Transactions on Aerospace and Electronic Systems (accepted)",
      year: 2026,
      is_pt: false,
      authors: (
        "Florindo, R. L.",
        "Pacelli, R. V.",
        "Silva, P. R. B.",
        "Antreich, F.",
        "Alves, D. I.",
        "Flores, E. S.",
        "Kriegel, M.",
        "Vasylyev, D.",
      )
    ),
    el2026: (
      title: "Machine learning-assisted blind emitter candidate generation in power spectrum analysis",
      publisher: "Electronics Letters",
      volume: "62",
      start-page: "1",
      end-page: "5",
      year: 2026,
      url: "https://doi.org/10.1049/ell2.70685",
      is_pt: false,
      authors: (
        "Flores, E. S.",
        "Florindo, R. L.",
        "Silva, P. R. B.",
        "Pacelli, R. V.",
        "Delgado, E.",
        "Lobao, F. S.",
        "Nunes, M.",
        "Alves, D. I.",
        "Machado, R.",
        "Antreich, F.",
      )
    ),
    dsp2025: (
      title: "An all-digital coherent AFSK demodulator for CubeSat applications",
      publisher: "Digital Signal Processing",
      volume: "162",
      start-page: "105147",
      year: 2025,
      url: "https://doi.org/10.1016/j.dsp.2025.105147",
      is_pt: false,
      authors: (
        "Pacelli, R. V.",
        "Florindo, R. L.",
        "Antreich, F.",
        "de Lucena, A. M. P.",
      )
    ),
    bjd2020: (
      title: "Fully digital GMSK modem with noncoherent demodulation",
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
      title: "Carrier synchronization technique for OFDM communication systems",
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
        "Lucena, A. M. P.",
        "Figueiredo, S. S.",
      )
    ),
    bjd2020b: (
      title: "Carrier selection technique for OFDM system in time-dispersive channels",
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
      title: "OFDM system with frequency and phase estimators for carrier synchronization",
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
    navicon2026: (
      title: "Multifrequency Ionospheric Irregularity Parameter Inference Using GNSS Signals",
      from: "IEEE Navigation Conference (NAVICON) 2026",
      year: 2026,
      is_pt: false,
      authors: (
        "Florindo, R. L.",
        "Pacelli, R. V.",
        "Vasylyev, D.",
        "Silva, P. R. B.",
        "Berdermann, J.",
        "Antreich, F.",
      )
    ),
    iongnss2026: (
      title: "Geometry-Aided Kalman-Based Tracking Loops for Ionospheric Scintillation Monitoring",
      from: "ION GNSS+ 2026",
      year: 2026,
      is_pt: false,
      authors: (
        "Pacelli, R. V.",
        "Florindo, R. L.",
        "Antreich, F.",
        "Kriegel, M.",
      )
    ),
    sbrt2026: (
      title: "Imbalance-Aware MobileNet for Automated Classification of Radio Technologies in Spectrograms",
      from: "SBrT 2026 - Brazilian Symposium on Telecommunications and Signal Processing",
      year: 2026,
      is_pt: false,
      authors: (
        "Flores, E. S.",
        "Silva, P. R. B.",
        "Florindo, R. L.",
        "Pacelli, R. V.",
        "Souza, F. J.",
        "Delgado, E.",
        "Lobao, F. S.",
        "Nunes, M.",
        "Alves, D. I.",
        "Antreich, F.",
        "Machado, R.",
      )
    ),
    sbrt2026a: (
      title: "Fine-Tuned YOLOv26 for Automated Detection of Radio Signals in Spectrograms",
      from: "SBrT 2026 - Brazilian Symposium on Telecommunications and Signal Processing",
      year: 2026,
      is_pt: false,
      authors: (
        "Flores, E. S.",
        "Silva, P. R. B.",
        "Florindo, R. L.",
        "Pacelli, R. V.",
        "Medeiros, V. I. A.",
        "Delgado, E.",
        "Lobao, F. S.",
        "Nunes, M.",
        "Alves, D. I.",
        "Antreich, F.",
        "Machado, R.",
      )
    ),
    iongnss2025: (
      title: "Characterization of Ionospheric Scintillation Using Deep Learning Models",
      from: "38th International Technical Meeting of the Satellite Division of The Institute of Navigation (ION GNSS+ 2025)",
      start-page: "3339",
      end-page: "3352",
      year: 2025,
      url: "https://doi.org/10.33012/2025.20390",
      is_pt: false,
      authors: (
        "Pacelli, R. V.",
        "Florindo, R. L.",
        "Antreich, F.",
        "de Almeida, A. L. F.",
        "Aragon-Angel, A.",
        "Garcia, A. R.",
      )
    ),
    iongnss2025a: (
      title: "Advanced Kalman Filter Carrier Tracking: Performance Assessment Under Two Ionospheric Scintillation Models",
      from: "38th International Technical Meeting of the Satellite Division of The Institute of Navigation (ION GNSS+ 2025)",
      start-page: "3421",
      end-page: "3435",
      year: 2025,
      url: "https://doi.org/10.33012/2025.20395",
      is_pt: false,
      authors: (
        "Florindo, R. L.",
        "Pacelli, R. V.",
        "Ferreira, T. L.",
        "Silva, D. O.",
        "de Lucena, A. M. P.",
        "Antreich, F.",
      )
    ),
    iongnss2024: (
      title: "Convolutional Neural Networks for Time Series Classification of Ionospheric Scintillation",
      from: "37th International Technical Meeting of the Satellite Division of The Institute of Navigation (ION GNSS+ 2024)",
      start-page: "3019",
      year: 2024,
      url: "https://doi.org/10.33012/2024.19929",
      is_pt: false,
      authors: (
        "Pacelli, R. V.",
        "Aragon-Angel, A.",
        "García, A. R.",
        "de Almeida, A. L. F.",
        "Antreich, F.",
      )
    ),
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
      from: "XXXVIII Brazilian Symposium on Telecommunications and Signal Processing",
      start-page: "1",
      end-page: "5",
      year: 2020,
      url: "https://doi.org/10.14209/SBRT.2020.1570654898",
      is_pt: false,
      authors: (
        "Pacelli, R. V.",
        "Lucena, A. M. P.",
        "Mota, J. C. M.",
      )
    ),
    eip2018: (
      title: "Fully digital GMSK modem with noncoherent demodulation",
      from: "XXIV Research Initiation Meeting",
      year: 2018,
      is_pt: true,
      authors: (
        "Pacelli, R. V.",
        "Lucena, A. M. P.",
      )
    ),
    eip2017: (
      title: "Carrier synchronization technique for OFDM communication systems",
      from: "XXIII Research Initiation Meeting",
      year: 2017,
      is_pt: true,
      authors: (
        "Pacelli, R. V.",
        "Lucena, A. M. P.",
        "Figueiredo, S. S.",
      )
    ),
    eip2017a: (
      title: "Carrier selection technique for OFDM system in time-dispersive channels",
      from: "XXIII Research Initiation Meeting",
      year: 2017,
      is_pt: true,
      authors: (
        "Figueiredo, S. S.",
        "Lucena, A. M. P.",
        "Pacelli, R. V.",
      )
    ),
    ic_unifor2016: (
      title: "A technique for frequency synchronization in OFDM modulation",
      from: "XXII Research Initiation Meeting",
      start-page: "1",
      end-page: "5",
      year: 2016,
      url: "https://uol.unifor.br/oul/conteudosite/?cdConteudo=6946081",
      is_pt: true,
      authors: (
        "Mourão, J. A.",
        "Lucena, A. M. P.",
        "Araújo, D. C.",
        "Pacelli, R. V.",
      )
    ),
    eip2015: (
      title: "Energy efficiency in parallel programming",
      from: "XXI Research Initiation Meeting",
      year: 2015,
      is_pt: true,
      authors: (
        "Pacelli, R. V.",
        "Pontes, H. P.",
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
        "Moreira, N. A.",
        "Maciel, T. F.",
        "Kacou, M.",
        "Gosset, M.",
      )
    ),
    atena2021: (
      title: "Symbol time synchronization in OFDM systems",
      publisher: "Atena",
      book: "Exact and Earth Sciences: Exploration and Qualification of Different Technologies",
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
        "Mourão, J. A.",
      )
    ),
    bj2020: (
      title: "GMSK modem with noncoherent demodulation and all-digital implementation",
      publisher: "Brazilian Journals Editora",
      book: "The impacts of studies focused on exact sciences",
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
    title: "Digital demodulation architecture and coherent detection method for AFSK signals",
    is_pt: true,
    status: "filed; examination requested (Dec 2023)"
  )
)

#show: my_doc => my_template(info.name, color_theme,  my_doc)

= General Information
#add_general_info((
  info.city_state_country,
  [Last update: #datetime.today().display()],
  [#info.home_place.full (#info.home_place.initials)],
  [Mobile: #contact.cellphone],
  [#link(info.home_place.url)[#info.home_place.initials]-#link(info.program.url)[#info.program.initials], #link(info.second_place.url)[#info.second_place.initials]-#link(info.second_program.url)[#info.second_program.initials]],
  [ 
    #link(contact.website.url)[#box(image(contact.website.fig, height: 10pt))],
    #link(contact.email.url)[#box(image(contact.email.fig, height: 10pt))], 
    #link(contact.orcid.url)[#box(image(contact.orcid.fig, height: 10pt))], 
    #link(contact.lattes.url)[#box(image(contact.lattes.fig, height: 10pt))], 
    #link(contact.github.url)[#box(image(contact.github.fig, height: 10pt))], 
    #link(contact.scholar.url)[#box(image(contact.scholar.fig, height: 10pt))], 
    #link(contact.linkedin.url)[#box(image(contact.linkedin.fig, height: 10pt))]
  ]
))

= Career Summary

Skilled Engineer with academic experience in GNSS Signal Processing and multidisciplinary background in
- Statistical signal processing, system identification, and adaptive filtering.
- Software-defined radio, digital modems, and synchronization techniques.
- Deep learning, pattern recognition, and optimization theory.// artificial intelligence.
// - Estimation, detection and optimization theory.

= Education
#add_education(education.graduation)
#add_education(education.master)
#add_education(education.doctorate)

= Experience
#{
  set enum(numbering: "E1")
  for exp in experience {
    [+ #add_experience(exp.at(1))]
  }
}

= Projects and Research Funding
#{
  set enum(numbering: "Pr1")
  for res in research {
    [+ #add_research(res.at(1))]
  }
}

= Skills

== Technical
- Systems & network expertise:
    - GNU/Linux: UNIX Shell scripting, Linux system fundamentals, services and automation.
    - Networking: : SSH for remote access and tailscale for tunneling.
    - Container technologies: Docker Compose CLI, Docker image building, and Docker Hub for image hosting.
    - Code versioning and collaboration: Git, GitHub, GitHub Actions.
- Academic and scientific skill set:
    - Scientific programming languages: Python, Julia, R, MATLAB/Simulink, Octave.
    - Typesetting systems: LaTeX, Typst. Ability to write scientific documents, reports, and academic papers.
    - Patent and intellectual property: patent drafting, patent search, and patent filing.
- MLOps tools and its Data Science ecosystem:
  - Deep learning packages: PyTorch, Keras/TensorFlow.
  - Pipelines & orchestration: Data Version Control (DVC).
  - Data visualization & analysis: Studio Datachain.
  - Cloud platform services: Amazon Web Services (AWS)
- Embedded systems and hardware design:
    - System programming languages for firmware development: C, C++, and Assembly.
    - Computer architecture: register-level programming, interrupts, direct memory access, timers, ADC/DAC, PWM, linker scripts, bootloaders, and memory-mapped I/O.
    - PCB design: KiCad, Altium, signal and power integrity, EMC, design for manufacturing (DFM). Basic undertanding in KiCad+MCP for ultra-fast AI-driven prototyping and production of PCBs.
    - HDLs and FPGAs: VHDL and Quartus Prime for FPGA design and simulation.
    - Wired protocols: UART, SPI, I²C, CAN/CAN-FD, LIN, USB, Ethernet, Modbus
    - RTOS and OS: bare-metal programming, FreeRTOS kernel. Previous experience with an NXP Semiconductors' family, the FRDM Development Platform model KL25Z.
    - Embedded DSP and edge ML: fixed-point arithmetic, CMSIS-DSP, FIR/IIR filters, FFT, TensorFlow Lite Micro (LiteRT), Edge Impulse. Previous experience with low-level development of digital modems.
    - Software-defined radio (SDR) platforms: USRP, HackRF, ADALM-PLUTO, RTL-SDR. Experience with GNU Radio, automatized data acquisition, signal processing, and machine learning for SDR applications.

== Languages
- English: Professional working proficiency  (#link("https://github.com/tapyu/tapyu/blob/master/cv/Latex/figs/Toefl.pdf")[TOEFL IBT] and #link("https://github.com/tapyu/tapyu/blob/master/cv/Latex/figs/Cambridge\%20FCE.pdf")[Cambridge FCE] exams).
- Portuguese: Native speaker.

= Teaching and support

- I had experience as an assistant teacher in Digital Communications at #education.doctorate.university.initials during my #education.doctorate.level's degree in #education.doctorate.course.
- I had experience as an assistant teacher in Digital Signal Processing at #education.master.university.initials during my #education.master.level's degree in #education.doctorate.course.
- I had experience as an assistant teacher in Control Theory at #education.graduation.university.initials during my undergraduate in #education.graduation.course.

= Academic Activity and membership
== Associate member
- Brazilian Telecommunications Society (SBrT)

== Research networks
- #link("https://inct-signals.org")[INCT Signals]: National Institute of Science and Technology on Signal Processing, Communications, Sensing and Surveillance.

= Publications
My academic publications are also listed on #link(contact.scholar.url)[Google Scholar].

== Theses

#for (_, edu) in education [
  - #add_thesis(edu)
]

== Journal  Articles
#{
  set enum(numbering: "J1")
  for (_, article) in publications.jounal_articles [
    + #add_journal_article(article)
  ]
}

== Conference Proceedings
#{
  set enum(numbering: "C1")
  for (_, article) in publications.conferences [
    + #add_conference_proceedings(article)
  ]
}

== Book chapter
#{
  set enum(numbering: "BC1")
  for (_, chapter) in publications.book_chapter [
    + #add_book_chapter(chapter)
  ]
}

= Patents
#for (_, patent) in patents {
  add_patent(patent)
}