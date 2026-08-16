# Shavette Founding Salons function

This isolated Firebase Functions codebase receives the public landing-page
form, validates every field on the server and writes accepted applications to
`founding_salon_applications` in the `shavette-16c2f` Firestore database.

Deploy only this codebase from the repository root:

```bash
firebase deploy --only functions:founding-salons
```

The separate `founding-salons` codebase prevents this deployment from changing
or deleting the Cloud Functions maintained by the Shavette mobile-app
repository.

