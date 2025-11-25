import '../models/project.dart';

List<Project> myProjects = [
  Project(
    id: "cicloverso",
    title: "CicloVerso WebApp",
    subtitle: "Gestione prenotazioni · Dashboard amministrativa · Flask + SQLite",
    description: "Web app per prenotazioni e gestione clienti per un negozio di meccanica ciclistica.",
    descriptionLong:
        "CicloVerso è una piattaforma completa che permette la gestione delle prenotazioni, "
        "dei clienti e delle riparazioni in un'officina ciclistica. "
        "Il progetto integra un backend REST in Flask e un frontend Flutter basato su Material 3.",
    link: "https://github.com/MauroPot2/cicloversoWebApp",
    features: [
      "Prenotazione slot con calendario",
      "Dashboard admin completa",
      "Database SQLite",
      "Backend Flask REST",
      "Autenticazione utenti",
    ],
    architecture: """
Frontend: HTML5, CSS3, JavaScript, BootStrap 5.3.3, FullCalendar
Backend: Flask (REST API) 3.0.2
Database: SQLite
Deployment: Raspberry Pi 4 · Docker
""",
    snippet: """
@app.route('/api/slots', methods=['GET'])
def get_slots():
    slots = Slot.query.all()
    return jsonify([slot.serialize() for slot in slots])
""",
    images: [
      "assets/projects/cicloverso_1.png",
      "assets/projects/cicloverso_2.png",
    ],
  ),

  Project(
    id: "fantanews",
    title: "Fanta News",
    subtitle: "CSV Parser · Generazione articoli con AI",
    description:
        "Carica i CSV delle tue leghe di fantacalcio e lascia che l’AI crei articoli sportivi avvincenti.",
    descriptionLong:
        "FantaNews trasforma i dati grezzi delle leghe fantacalcio "
        "in articoli sportivi generati automaticamente con modelli AI. "
        "Sistema utile per leghe private o contenuti social.",
    link: "https://github.com/MauroPot2/fantanews-web-app",
    features: [
      "Parsing CSV personalizzati",
      "Generazione articoli con AI",
      "Analisi punteggi e statistiche",
      "Esportazione articoli",
    ],
    architecture: """
Frontend: HTML5, CSS3, JavaScript, BootStrap 5.3.3
Backend: Python (FastAPI)
AI: OpenAI GPT Models
File Parsing: CSV
""",
    snippet: """
final rows = await parseCsv(file);
final article = await aiService.generateArticle(rows);
""",
    images: [],
  ),

  Project(
    id: "portfolio",
    title: "Portfolio Flutter Web",
    subtitle: "Material 3 · Responsive UI · GoRouter",
    description: "Il portfolio che stai guardando!",
    descriptionLong:
        "Portfolio personale realizzato in Flutter Web con layout responsive, "
        "supporto Light/Dark Mode, routing avanzato e pagine tecniche dedicate per ogni progetto.",
    link: "https://github.com/MauroPot2/porrtfolioFlutterWeb",
    features: [
      "Navbar responsive con hamburger menu",
      "Dark/Light theme con ColorScheme",
      "Pagine progetto dedicate",
      "Animazioni hover",
      "GoRouter per navigation",
    ],
    architecture: """
Frontend: Flutter Web
Routing: GoRouter
UI Kit: Material 3 + custom theme
Deployment: GitHub Pages (Web)
""",
    snippet: """
GoRoute(
  path: '/projects/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return ProjectDetailsPage(projectId: id);
  },
),
""",
    images: [],
  ),
];
