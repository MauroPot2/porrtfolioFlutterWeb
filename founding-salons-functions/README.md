# Shavette Founding Salons function

This isolated Firebase Functions codebase receives the public landing-page
form, validates every field on the server and writes accepted applications to
`founding_salon_applications` in the `shavette-16c2f` Firestore database.

To keep operating costs predictable, the HTTP function scales to zero, has a
single maximum instance and applies an in-memory per-client/global rate limit
before writing to Firestore. The limit is deliberately in memory: it adds no
extra database operations and is a low-cost abuse barrier, not a hard billing
cap or a replacement for a managed CAPTCHA under a large paid campaign.

Deploy only this codebase from the repository root:

```bash
firebase deploy --only functions:founding-salons
```

The separate `founding-salons` codebase prevents this deployment from changing
or deleting the Cloud Functions maintained by the Shavette mobile-app
repository.
