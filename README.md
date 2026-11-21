# Portfolio Flutter Web

Sito portfolio personale realizzato con Flutter Web. Il progetto presenta profilo, competenze e lavori, con pagine dedicate ai progetti e ai contatti.

## Funzionalità

- Homepage e presentazione personale
- Elenco progetti e schede di dettaglio
- Sezione informazioni e contatti
- Navigazione tramite `go_router`
- Collegamenti esterni e contenuti visuali per i progetti

## Stack

Flutter, Dart, `go_router`, `url_launcher`, `http` e componenti animati. Il repository include anche configurazione Firebase Hosting e una cartella separata per funzioni legate alle iniziative del portfolio.

## Struttura

L'app Flutter non si trova nella root ma in `portfolioflutterweb/`.

- `portfolioflutterweb/lib/pages/`: home, progetti, dettagli, informazioni e contatti
- `portfolioflutterweb/lib/router/`: navigazione
- `portfolioflutterweb/lib/data/`: dati visualizzati dal sito
- `portfolioflutterweb/assets/`: immagini e contenuti dei progetti
- `founding-salons-functions/`: codice server separato

## Avvio locale

~~~bash
cd portfolioflutterweb
flutter pub get
flutter run -d chrome
~~~

Per distribuire il sito, consultare la configurazione `firebase.json` e verificare la destinazione Hosting prima del deploy.

## Note

Il portfolio ha lo scopo di mostrare progetti realmente sviluppati. Descrizioni, collegamenti, immagini e stato di ogni lavoro dovrebbero essere mantenuti aggiornati e distinguere le applicazioni distribuite dai prototipi.
