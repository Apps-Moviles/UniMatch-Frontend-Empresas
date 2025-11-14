import 'package:unimatch_empresas/views/projects/domain/project.dart';

final List<Project> mockedProjects = [
  Project(
    title: 'Front-End Design',
    status: ProjectStatusEnum.inProgress,
    createdAt: '1/10/2025',
    description:
        "Se busca personal para encargarse del diseño de nuestra pagina web para nuestra empresa dedicada al desarrollo de soluciones tecnologicas. La pagina debe transmitir una imagen moderna, profesional y alineada con nuestros valores de innovacion, confianza y excelencia.",
    requirements: """
      * Se busca gente con experiencia previa en diseño web responsive.
      * Dominio de herrramientas como Figma, Adobe XD o similares.
      * Conocimientos basicos de HTML/CSS son un plus.
      * Buen criterio visual y atencion al detalle.
    """,
    duration: "De 2 a 3 semanas",
    payment: "200 dolares",
  ),

  Project(
    title: 'Desarrollo de API REST',
    status: ProjectStatusEnum.acepted,
    createdAt: '5/10/2025',
    description:
        "Necesitamos desarrollar una API REST para gestionar usuarios, productos y pedidos de nuestra plataforma de comercio electrónico.",
    requirements: """
      * Experiencia con frameworks como Node.js o Django.
      * Conocimientos en bases de datos relacionales (PostgreSQL o MySQL).
      * Implementación de autenticación JWT.
      * Documentación clara del API (Swagger u OpenAPI).
    """,
    duration: "4 semanas",
    payment: "400 dolares",
  ),

  Project(
    title: 'Aplicación móvil Flutter',
    status: ProjectStatusEnum.inProgress,
    createdAt: '10/10/2025',
    description:
        "Desarrollo de una aplicación móvil multiplataforma para gestión de tareas personales. Debe incluir login, sincronización en la nube y notificaciones push.",
    requirements: """
      * Experiencia comprobable con Flutter y Dart.
      * Conocimientos de Firebase (Auth, Firestore, Cloud Messaging).
      * Diseño adaptativo para Android e iOS.
      * Buenas prácticas de arquitectura (MVVM o Clean Architecture).
    """,
    duration: "6 semanas",
    payment: "600 dolares",
  ),

  Project(
    title: 'Rediseño de identidad visual',
    status: ProjectStatusEnum.acepted,
    createdAt: '15/9/2025',
    description:
        "Se requiere un rediseño completo del logotipo, paleta de colores y tipografía para modernizar la marca de la empresa.",
    requirements: """
      * Experiencia en branding e identidad corporativa.
      * Uso avanzado de Adobe Illustrator o Photoshop.
      * Entrega de archivos editables y manual de marca.
    """,
    duration: "3 semanas",
    payment: "300 dolares",
  ),

  Project(
    title: 'Optimización SEO para blog',
    status: ProjectStatusEnum.rejected,
    createdAt: '20/10/2025',
    description:
        "Optimización del posicionamiento en buscadores para un blog de tecnología. Se busca mejorar el tráfico orgánico y visibilidad en Google.",
    requirements: """
      * Conocimientos de SEO on-page y off-page.
      * Experiencia con Google Search Console y Analytics.
      * Capacidad para realizar auditorías técnicas.
      * Dominio básico de HTML y metaetiquetas.
    """,
    duration: "2 semanas",
    payment: "150 dolares",
  ),

  Project(
    title: 'Dashboard Administrativo',
    status: ProjectStatusEnum.inProgress,
    createdAt: '25/10/2025',
    description:
        "Construcción de un panel administrativo web para gestionar usuarios y reportes de ventas en tiempo real.",
    requirements: """
      * Experiencia con frameworks frontend como React o Vue.
      * Integración con APIs RESTful.
      * Conocimientos en diseño UI/UX.
      * Uso de librerías de gráficos como Chart.js o ECharts.
    """,
    duration: "5 semanas",
    payment: "500 dolares",
  ),

  Project(
    title: 'Automatización de reportes',
    status: ProjectStatusEnum.rejected,
    createdAt: '1/8/2025',
    description:
        "Creación de scripts en Python para automatizar la generación de reportes financieros a partir de archivos Excel.",
    requirements: """
      * Dominio de Python y librerías como Pandas y OpenPyXL.
      * Capacidad para programar tareas automáticas (cronjobs o schedulers).
      * Generación de reportes en PDF o CSV.
    """,
    duration: "2 semanas",
    payment: "250 dolares",
  ),

  Project(
    title: 'Campaña de marketing digital',
    status: ProjectStatusEnum.inProgress,
    createdAt: '30/10/2025',
    description:
        "Lanzamiento de una campaña publicitaria en redes sociales para promocionar un nuevo producto tecnológico.",
    requirements: """
      * Experiencia en Meta Ads y Google Ads.
      * Conocimiento en análisis de métricas (CPC, CTR, ROI).
      * Creatividad para creación de contenido atractivo.
    """,
    duration: "3 semanas",
    payment: "350 dolares",
  ),

  Project(
    title: 'Implementación de chatbot con IA',
    status: ProjectStatusEnum.acepted,
    createdAt: '2/11/2025',
    description:
        "Integración de un chatbot basado en inteligencia artificial para atención al cliente en el sitio web principal.",
    requirements: """
      * Conocimientos en APIs de IA (OpenAI, Dialogflow, etc.).
      * Capacidad para integrar con backend existente.
      * Diseño de flujos conversacionales naturales.
      * Pruebas de usabilidad y ajustes según feedback.
    """,
    duration: "6 semanas",
    payment: "700 dolares",
  ),
];
