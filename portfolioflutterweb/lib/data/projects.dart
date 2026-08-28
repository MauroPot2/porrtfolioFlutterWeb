import '../models/project.dart';

List<Project> myProjects = [
  Project(
    id: "shavette",
    title: "Shavette",
    subtitle: "Flutter Product Case Study · Booking SaaS",
    description:
        "Prodotto mobile sviluppato end-to-end con Flutter e Firebase: booking, ruoli, backend serverless, notifiche, subscription e release multi-brand.",
    descriptionLong:
        "Shavette è il progetto con cui mostro come affronto problemi reali di prodotto oltre la UI. La stessa codebase gestisce flussi cliente e professionista, autenticazione, permessi staff, prenotazioni, backend Firebase, notifiche FCM, subscription RevenueCat e flavor distinti per più brand.",
    link: "https://mauropot.com/shavette",
    features: [
      "Booking e disponibilità con Cloud Firestore",
      "State management con Riverpod e routing con GoRouter",
      "Firebase Authentication, ruoli owner/staff e access control",
      "Cloud Functions Node.js per logiche server-side",
      "Push notification e reminder con Firebase Cloud Messaging",
      "Subscription ed entitlement con RevenueCat",
      "Flavor Android/iOS per distribuzione white-label",
    ],
    architecture: """
Frontend: Flutter, Dart
State management: Riverpod
Routing: GoRouter
Backend: Firebase Cloud Functions (Node.js)
Auth & data: Firebase Authentication, Cloud Firestore
Messaging: Firebase Cloud Messaging + local notifications
Subscription: RevenueCat
Release: Android / iOS, Flutter flavors
""",
    snippet: null,
    images: [
      "assets/images/shavette/shavette_agenda.jpg",
    ],
  ),
  Project(
    id: "cicloverso",
    title: "CicloVerso WebApp",
    subtitle: "Gestionale Amministrativo B2B",
    description:
        "Piattaforma web completa per la gestione di appuntamenti, riparazioni e anagrafiche clienti per un'officina meccanica.",
    descriptionLong:
        "CicloVerso è un gestionale che digitalizza le operazioni di un'officina. Include un sistema di slot temporali per le prenotazioni, un'interfaccia di amministrazione sicura per il personale e un database strutturato per tracciare lo storico degli interventi.",
    link: "https://github.com/MauroPot2/cicloversoWebApp",
    features: [
      "Calendario prenotazioni dinamico",
      "Dashboard amministrativa sicura",
      "Gestione anagrafica clienti e storico",
      "Integrazione API RESTful",
    ],
    architecture: """
Frontend: HTML5, CSS3, JavaScript, BootStrap 5.3.3
Backend: Python, Flask (REST API)
Database: SQLite / PostgreSQL
Ambiente: Virtual Environments, Deployment locale/cloud
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
    id: "mantra-matrix",
    title: "Mantra Matrix",
    subtitle: "Data-Driven Web Service",
    description:
        "Motore backend ad alte prestazioni per l'acquisizione, elaborazione e proiezione matematica di metriche sportive.",
    descriptionLong:
        "Un servizio web orientato all'analisi dei dati che processa grandi moli di informazioni grezze estrapolate dal web. Attraverso algoritmi di scraping asincrono, normalizza i dati e restituisce modelli predittivi e metriche di valutazione avanzate (es. expected goals, clean sheets).",
    link: "#",
    features: [
      "Web scraping asincrono da fonti multiple",
      "Algoritmi custom di data modeling",
      "Strutturazione di backend RESTful",
      "Pipeline di elaborazione dati",
    ],
    architecture: """
Frontend: Interfaccia analitica Web
Backend: Python, Flask
Data Ingestion: Async Web Scraping Tools
Modellazione: Algoritmi matematici custom
""",
    snippet: """
async def fetch_and_process_metrics():
    raw_data = await scraper_wrapper.get_latest_stats()
    return metric_engine.calculate_projections(raw_data)
""",
    images: [],
  ),
  Project(
    id: "ponte-restaurant",
    title: "Ponte Italian Restaurant",
    subtitle: "Sito Vetrina per Ristorazione (In Sviluppo)",
    description:
        "Sito web moderno e responsive progettato per un cliente del settore ristorazione, ospitato su infrastruttura Firebase.",
    descriptionLong:
        "Progetto in corso di sviluppo per un ristorante italiano. L'obiettivo della piattaforma è fornire una vetrina digitale elegante e performante, che trasmetta l'atmosfera del locale e consenta agli utenti di consultare agevolmente il menu, con una forte ottimizzazione per i dispositivi mobili.",
    link: "https://ponteitalianrestaurant.web.app/",
    features: [
      "Design responsivo (Mobile-First)",
      "Interfaccia utente elegante e in linea col brand",
      "Ottimizzazione delle performance",
      "Deployment scalabile su Google Firebase Hosting",
    ],
    architecture: """
Frontend: (Inserisci qui lo stack usato, es. Flutter Web o HTML/CSS/JS)
Deployment: Google Firebase Hosting
Stato: Work in Progress
""",
    snippet:
        null, // Puoi ometterlo se non vuoi mostrare codice per questo progetto
    images: [
      // "assets/projects/ponte_1.png", <-- Ricordati di aggiungere uno screenshot della home appena puoi
    ],
  ),
];
