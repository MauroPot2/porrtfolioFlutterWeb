const admin = require("firebase-admin");
const { onRequest } = require("firebase-functions/v2/https");

if (admin.apps.length === 0) {
  admin.initializeApp();
}

const ALLOWED_ORIGINS = new Set([
  "https://mauropot.com",
  "https://www.mauropot.com",
  "https://mauropot2.github.io",
]);

const BOOKING_METHOD_LABELS = Object.freeze({
  whatsapp_phone: "WhatsApp / telefono",
  paper_agenda: "Agenda cartacea",
  google_calendar: "Google Calendar",
  other_software: "Altro gestionale",
  no_system: "Non utilizza un sistema preciso",
});

class ValidationError extends Error {}

function isAllowedOrigin(origin) {
  if (ALLOWED_ORIGINS.has(origin)) return true;

  return (
    /^http:\/\/localhost:\d+$/.test(origin) ||
    /^http:\/\/127\.0\.0\.1:\d+$/.test(origin)
  );
}

function readText(
  value,
  fieldName,
  { required = true, maxLength = 120 } = {},
) {
  const text = typeof value === "string" ? value.trim() : "";
  if (required && text.length === 0) {
    throw new ValidationError(`${fieldName} mancante.`);
  }
  if (text.length > maxLength) {
    throw new ValidationError(`${fieldName} troppo lungo.`);
  }
  return text;
}

function readTrackingValue(value) {
  const text = readText(value, "Parametro UTM", {
    required: false,
    maxLength: 120,
  });
  return text || null;
}

function validateEmail(value) {
  const email = readText(value, "Email", { maxLength: 254 }).toLowerCase();
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    throw new ValidationError("Email non valida.");
  }
  return email;
}

function validatePhone(value) {
  const phone = readText(value, "Telefono", { maxLength: 32 });
  if (!/^[+()\d\s./-]+$/.test(phone)) {
    throw new ValidationError("Numero di telefono non valido.");
  }

  const digits = phone.replace(/\D/g, "");
  if (digits.length < 7 || digits.length > 15) {
    throw new ValidationError("Numero di telefono non valido.");
  }
  return phone;
}

function validateStaffCount(value) {
  const count = Number(value);
  if (!Number.isInteger(count) || ![1, 2, 3, 4].includes(count)) {
    throw new ValidationError("Numero di barbieri non valido.");
  }
  return count;
}

function validateBookingMethod(value) {
  if (
    typeof value !== "string" ||
    !Object.hasOwn(BOOKING_METHOD_LABELS, value)
  ) {
    throw new ValidationError("Metodo di prenotazione non valido.");
  }
  return value;
}

function validateApplication(body) {
  if (body == null || typeof body !== "object" || Array.isArray(body)) {
    throw new ValidationError("Dati della candidatura non validi.");
  }

  if (readText(body.website, "Website", { required: false, maxLength: 80 })) {
    throw new ValidationError("Candidatura non valida.");
  }

  if (body.privacyAccepted !== true) {
    throw new ValidationError(
      "È necessario accettare il trattamento dei dati.",
    );
  }

  const staffCount = validateStaffCount(body.staffCount);
  const bookingMethod = validateBookingMethod(body.bookingMethod);
  const utmSource = readTrackingValue(body.utmSource);

  return {
    salonName: readText(body.salonName, "Nome del salone", {
      maxLength: 120,
    }),
    city: readText(body.city, "Città", { maxLength: 80 }),
    staffCount,
    staffCountLabel: staffCount === 4 ? "4+" : String(staffCount),
    ownerName: readText(body.ownerName, "Nome e cognome", {
      maxLength: 120,
    }),
    email: validateEmail(body.email),
    phone: validatePhone(body.phone),
    instagram: readText(body.instagram, "Instagram", {
      required: false,
      maxLength: 100,
    }),
    bookingMethod,
    bookingMethodLabel: BOOKING_METHOD_LABELS[bookingMethod],
    status: "pending",
    source: utmSource || "direct",
    utmSource,
    utmMedium: readTrackingValue(body.utmMedium),
    utmCampaign: readTrackingValue(body.utmCampaign),
    utmTerm: readTrackingValue(body.utmTerm),
    utmContent: readTrackingValue(body.utmContent),
    landingPath: readText(body.landingPath, "Percorso pagina", {
      required: false,
      maxLength: 160,
    }),
    privacyAccepted: true,
    privacyPolicyVersion: readText(
      body.privacyPolicyVersion,
      "Versione informativa privacy",
      { maxLength: 80 },
    ),
  };
}

function setResponseHeaders(response, origin) {
  response.set("Access-Control-Allow-Origin", origin);
  response.set("Access-Control-Allow-Methods", "POST, OPTIONS");
  response.set("Access-Control-Allow-Headers", "Content-Type, Accept");
  response.set("Access-Control-Max-Age", "3600");
  response.set("Vary", "Origin");
  response.set("Cache-Control", "no-store");
  response.set("X-Content-Type-Options", "nosniff");
}

exports.submitFoundingSalonApplication = onRequest(
  {
    region: "europe-west1",
    timeoutSeconds: 15,
    memory: "256MiB",
    maxInstances: 10,
  },
  async (request, response) => {
    const origin = request.get("origin") || "";
    if (!isAllowedOrigin(origin)) {
      response.status(403).json({
        ok: false,
        message: "Origine della richiesta non autorizzata.",
      });
      return;
    }

    setResponseHeaders(response, origin);

    if (request.method === "OPTIONS") {
      response.status(204).send("");
      return;
    }

    if (request.method !== "POST") {
      response.status(405).json({
        ok: false,
        message: "Metodo non consentito.",
      });
      return;
    }

    const contentType = request.get("content-type") || "";
    if (!contentType.toLowerCase().includes("application/json")) {
      response.status(415).json({
        ok: false,
        message: "Invia la candidatura in formato JSON.",
      });
      return;
    }

    try {
      if (JSON.stringify(request.body ?? {}).length > 12_000) {
        throw new ValidationError("Candidatura troppo grande.");
      }

      const application = validateApplication(request.body);
      const timestamp = admin.firestore.FieldValue.serverTimestamp();
      const document = await admin
        .firestore()
        .collection("founding_salon_applications")
        .add({
          ...application,
          createdAt: timestamp,
          updatedAt: timestamp,
        });

      response.status(201).json({
        ok: true,
        applicationId: document.id,
      });
    } catch (error) {
      if (error instanceof ValidationError) {
        response.status(400).json({
          ok: false,
          message: error.message,
        });
        return;
      }

      console.error("Founding Salon application failed", error);
      response.status(500).json({
        ok: false,
        message: "Non è stato possibile salvare la candidatura. Riprova.",
      });
    }
  },
);

exports._test = {
  isAllowedOrigin,
  validateApplication,
  ValidationError,
};

