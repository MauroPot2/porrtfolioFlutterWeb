const assert = require("node:assert/strict");
const { describe, it } = require("node:test");

const { _test } = require("../index");

function validPayload(overrides = {}) {
  return {
    salonName: "Barber Club",
    city: "Catanzaro",
    staffCount: 3,
    ownerName: "Mario Rossi",
    email: "mario@example.com",
    phone: "+39 333 123 4567",
    instagram: "@barberclub",
    bookingMethod: "whatsapp_phone",
    privacyAccepted: true,
    privacyPolicyVersion: "2026-08-15-founding-salons",
    utmSource: "facebook",
    utmMedium: "social",
    utmCampaign: "founding-salons",
    utmTerm: null,
    utmContent: null,
    landingPath: "/shavette",
    website: "",
    ...overrides,
  };
}

describe("Founding Salons validation", () => {
  it("normalizes a valid application and keeps UTM attribution", () => {
    const application = _test.validateApplication(validPayload());

    assert.equal(application.salonName, "Barber Club");
    assert.equal(application.staffCount, 3);
    assert.equal(application.source, "facebook");
    assert.equal(application.status, "pending");
    assert.equal(application.bookingMethodLabel, "WhatsApp / telefono");
  });

  it("uses direct as source when UTM source is absent", () => {
    const application = _test.validateApplication(
      validPayload({ utmSource: null }),
    );

    assert.equal(application.source, "direct");
    assert.equal(application.utmSource, null);
  });

  it("maps 4 to the 4+ staff range", () => {
    const application = _test.validateApplication(
      validPayload({ staffCount: 4 }),
    );

    assert.equal(application.staffCount, 4);
    assert.equal(application.staffCountLabel, "4+");
  });

  it("rejects missing privacy consent", () => {
    assert.throws(
      () => _test.validateApplication(validPayload({ privacyAccepted: false })),
      /accettare il trattamento/i,
    );
  });

  it("rejects invalid booking methods", () => {
    assert.throws(
      () => _test.validateApplication(validPayload({ bookingMethod: "fax" })),
      /metodo di prenotazione/i,
    );
  });

  it("rejects the honeypot field when filled", () => {
    assert.throws(
      () => _test.validateApplication(validPayload({ website: "spam.test" })),
      /candidatura non valida/i,
    );
  });
});

describe("CORS origin allowlist", () => {
  it("accepts production and local development origins", () => {
    assert.equal(_test.isAllowedOrigin("https://mauropot.com"), true);
    assert.equal(_test.isAllowedOrigin("http://localhost:5173"), true);
  });

  it("rejects unrelated origins", () => {
    assert.equal(_test.isAllowedOrigin("https://example.com"), false);
    assert.equal(_test.isAllowedOrigin(""), false);
  });
});

