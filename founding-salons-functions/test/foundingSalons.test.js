const assert = require("node:assert/strict");
const { describe, it } = require("node:test");

const { _test } = require("../index");

const NOW = 1_786_870_800_000;

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
    formStartedAt: NOW - 5_000,
    formVersion: "static-2026-08-16-v1",
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
    const application = _test.validateApplication(validPayload(), NOW);

    assert.equal(application.salonName, "Barber Club");
    assert.equal(application.staffCount, 3);
    assert.equal(application.source, "facebook");
    assert.equal(application.status, "pending");
    assert.equal(application.bookingMethodLabel, "WhatsApp / telefono");
  });

  it("uses direct as source when UTM source is absent", () => {
    const application = _test.validateApplication(
      validPayload({ utmSource: null }),
      NOW,
    );

    assert.equal(application.source, "direct");
    assert.equal(application.utmSource, null);
  });

  it("maps 4 to the 4+ staff range", () => {
    const application = _test.validateApplication(
      validPayload({ staffCount: 4 }),
      NOW,
    );

    assert.equal(application.staffCount, 4);
    assert.equal(application.staffCountLabel, "4+");
  });

  it("rejects missing privacy consent", () => {
    assert.throws(
      () =>
        _test.validateApplication(
          validPayload({ privacyAccepted: false }),
          NOW,
        ),
      /accettare il trattamento/i,
    );
  });

  it("rejects invalid booking methods", () => {
    assert.throws(
      () =>
        _test.validateApplication(
          validPayload({ bookingMethod: "fax" }),
          NOW,
        ),
      /metodo di prenotazione/i,
    );
  });

  it("rejects the honeypot field when filled", () => {
    assert.throws(
      () =>
        _test.validateApplication(
          validPayload({ website: "spam.test" }),
          NOW,
        ),
      /candidatura non valida/i,
    );
  });

  it("rejects forms submitted unrealistically quickly", () => {
    assert.throws(
      () =>
        _test.validateApplication(
          validPayload({ formStartedAt: NOW - 500 }),
          NOW,
        ),
      /candidatura non valida/i,
    );
  });

  it("rejects obsolete form clients", () => {
    assert.throws(
      () =>
        _test.validateApplication(
          validPayload({ formVersion: "flutter-old" }),
          NOW,
        ),
      /candidatura non valida/i,
    );
  });
});

describe("CORS origin allowlist", () => {
  it("accepts production and local development origins", () => {
    assert.equal(_test.isAllowedOrigin("https://mauropot.com"), true);
    assert.equal(
      _test.isAllowedOrigin("https://portfolio-15-v1.web.app"),
      true,
    );
    assert.equal(_test.isAllowedOrigin("http://localhost:5173"), true);
  });

  it("rejects unrelated origins", () => {
    assert.equal(_test.isAllowedOrigin("https://example.com"), false);
    assert.equal(_test.isAllowedOrigin(""), false);
  });
});

describe("in-memory submission rate limiter", () => {
  it("enforces both per-client and global limits without Firestore", () => {
    const limiter = _test.createSubmissionRateLimiter({
      globalLimit: 2,
      globalWindowMs: 1_000,
      clientLimit: 1,
      clientWindowMs: 10_000,
    });

    assert.equal(limiter.take("client-a", 0).allowed, true);
    assert.equal(limiter.take("client-a", 10).allowed, false);
    assert.equal(limiter.take("client-b", 10).allowed, true);
    assert.equal(limiter.take("client-c", 10).allowed, false);
  });

  it("releases capacity after the configured window", () => {
    const limiter = _test.createSubmissionRateLimiter({
      globalLimit: 1,
      globalWindowMs: 1_000,
      clientLimit: 2,
      clientWindowMs: 10_000,
    });

    assert.equal(limiter.take("client-a", 0).allowed, true);
    assert.equal(limiter.take("client-b", 500).allowed, false);
    assert.equal(limiter.take("client-b", 1_001).allowed, true);
  });
});
