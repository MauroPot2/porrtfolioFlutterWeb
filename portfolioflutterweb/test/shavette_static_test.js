const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const { describe, it } = require("node:test");

const projectRoot = path.resolve(__dirname, "..");
const repositoryRoot = path.resolve(projectRoot, "..");
const landingRoot = path.join(projectRoot, "web", "shavette");

const html = fs.readFileSync(path.join(landingRoot, "index.html"), "utf8");
const termsHtml = fs.readFileSync(
  path.join(landingRoot, "terms", "index.html"),
  "utf8",
);
const privacyHtml = fs.readFileSync(
  path.join(landingRoot, "privacy", "index.html"),
  "utf8",
);
const css = fs.readFileSync(path.join(landingRoot, "styles.v1.css"), "utf8");
const legalCss = fs.readFileSync(path.join(landingRoot, "terms.v1.css"), "utf8");
const javascript = fs.readFileSync(path.join(landingRoot, "app.v3.js"), "utf8");
const consentJavascript = fs.readFileSync(
  path.join(landingRoot, "consent.v1.js"),
  "utf8",
);

describe("Shavette static landing", () => {
  it("does not load the Flutter runtime", () => {
    assert.doesNotMatch(html, /flutter_bootstrap|main\.dart\.js|canvaskit/i);
    assert.match(html, /\/shavette\/app\.v3\.js/);
    assert.match(html, /\/shavette\/styles\.v1\.css/);
  });

  it("keeps the complete application form and attribution fields", () => {
    for (const field of [
      "salonName",
      "city",
      "staffCount",
      "ownerName",
      "email",
      "phone",
      "instagram",
      "bookingMethod",
      "privacyAccepted",
      "website",
    ]) {
      assert.match(html, new RegExp(`name="${field}"`));
    }

    for (const parameter of [
      "utm_source",
      "utm_medium",
      "utm_campaign",
      "utm_term",
      "utm_content",
    ]) {
      assert.match(javascript, new RegExp(parameter));
    }

    assert.match(html, /href="\/shavette\/privacy"/);
    assert.match(javascript, /PRIVACY_VERSION = '2026-11-03'/);
  });

  it("stays below a 140 KB source payload", () => {
    const files = [
      path.join(landingRoot, "index.html"),
      path.join(landingRoot, "styles.v1.css"),
      path.join(landingRoot, "app.v3.js"),
      path.join(projectRoot, "assets", "images", "shavette", "shavette_agenda.jpg"),
      path.join(projectRoot, "assets", "images", "shavette", "shavette_icon.jpg"),
    ];
    const totalBytes = files.reduce(
      (total, file) => total + fs.statSync(file).size,
      0,
    );

    assert.ok(totalBytes < 140_000, `Landing payload is ${totalBytes} bytes`);
  });

  it("uses the dedicated Hosting rewrite and restrictive CSP", () => {
    const firebaseConfig = JSON.parse(
      fs.readFileSync(path.join(repositoryRoot, "firebase.json"), "utf8"),
    );
    const rewrite = firebaseConfig.hosting.rewrites.find(
      (entry) => entry.source === "/shavette",
    );
    const landingHeaders = firebaseConfig.hosting.headers.find(
      (entry) => entry.source === "/shavette",
    );

    assert.equal(rewrite.destination, "/shavette/index.html");
    assert.ok(
      landingHeaders.headers.some(
        (header) =>
          header.key === "Content-Security-Policy" &&
          header.value.includes("script-src 'self' https://www.googletagmanager.com") &&
          header.value.includes("frame-ancestors 'none'"),
      ),
    );
  });

  it("contains no inline scripts or styles blocked by the CSP", () => {
    assert.doesNotMatch(html, /<script(?![^>]*\bsrc=)[^>]*>/i);
    assert.doesNotMatch(html, /<style\b/i);
    assert.ok(css.length > 0);
  });

  it("loads Google Ads measurement consistently and converts only successful applications", () => {
    for (const page of [html, termsHtml, privacyHtml]) {
      assert.match(
        page,
        /googletagmanager\.com\/gtag\/js\?id=AW-18503833834/,
      );
      assert.match(page, /\/shavette\/consent\.v1\.js/);
      assert.match(page, /\/shavette\/consent\.v1\.css/);
      assert.doesNotMatch(page, /<script(?![^>]*\bsrc=)[^>]*>/i);
    }

    assert.match(consentJavascript, /gtag\('config', 'AW-18503833834'\)/);
    assert.match(
      javascript,
      /send_to: 'AW-18503833834\/pvJxCLWxhpcdEOqxqPdE'/,
    );
    assert.match(javascript, /value: 1\.0/);
    assert.match(javascript, /currency: 'EUR'/);
    assert.match(
      javascript,
      /await submitApplication\(payload\);\s*reportGoogleAdsConversion\(\);/,
    );
  });

  it("publishes the Shavette terms page at the clean legal URL", () => {
    const firebaseConfig = JSON.parse(
      fs.readFileSync(path.join(repositoryRoot, "firebase.json"), "utf8"),
    );
    const rewrite = firebaseConfig.hosting.rewrites.find(
      (entry) => entry.source === "/shavette/terms",
    );
    const termsHeaders = firebaseConfig.hosting.headers.find(
      (entry) => entry.source === "/shavette/terms",
    );

    assert.equal(rewrite.destination, "/shavette/terms/index.html");
    assert.match(termsHtml, /Termini di utilizzo di Shavette/);
    assert.match(termsHtml, /Ultimo aggiornamento: 5 settembre 2026/);
    assert.match(termsHtml, /\/shavette\/terms\.v1\.css/);
    assert.doesNotMatch(termsHtml, /<style\b/i);
    assert.ok(legalCss.length > 0);
    assert.ok(
      termsHeaders.headers.some(
        (header) =>
          header.key === "Content-Security-Policy" &&
          header.value.includes("script-src 'self' https://www.googletagmanager.com") &&
          header.value.includes("frame-ancestors 'none'"),
      ),
    );
  });

  it("publishes a comprehensive Shavette privacy page at the clean legal URL", () => {
    const firebaseConfig = JSON.parse(
      fs.readFileSync(path.join(repositoryRoot, "firebase.json"), "utf8"),
    );
    const rewrite = firebaseConfig.hosting.rewrites.find(
      (entry) => entry.source === "/shavette/privacy",
    );
    const privacyHeaders = firebaseConfig.hosting.headers.find(
      (entry) => entry.source === "/shavette/privacy",
    );

    assert.equal(rewrite.destination, "/shavette/privacy/index.html");
    assert.match(privacyHtml, /Come Shavette tratta i tuoi dati/);
    assert.match(privacyHtml, /Ultimo aggiornamento: 3 novembre 2026/);
    assert.match(privacyHtml, /Firebase Crashlytics/);
    assert.match(privacyHtml, /Firebase Performance Monitoring/);
    assert.match(privacyHtml, /RevenueCat/);
    assert.match(privacyHtml, /Resend/);
    assert.match(privacyHtml, /Google Ads e Consent Mode/);
    assert.match(privacyHtml, /Founding Salons/);
    assert.match(privacyHtml, /href="\/shavette\/terms"/);
    assert.match(privacyHtml, /\/shavette\/terms\.v1\.css/);
    assert.doesNotMatch(privacyHtml, /<style\b/i);
    assert.ok(
      privacyHeaders.headers.some(
        (header) =>
          header.key === "Content-Security-Policy" &&
          header.value.includes("script-src 'self' https://www.googletagmanager.com") &&
          header.value.includes("frame-ancestors 'none'"),
      ),
    );
  });
});
