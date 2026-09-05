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
const css = fs.readFileSync(path.join(landingRoot, "styles.v1.css"), "utf8");
const termsCss = fs.readFileSync(path.join(landingRoot, "terms.v1.css"), "utf8");
const javascript = fs.readFileSync(path.join(landingRoot, "app.v1.js"), "utf8");

describe("Shavette static landing", () => {
  it("does not load the Flutter runtime", () => {
    assert.doesNotMatch(html, /flutter_bootstrap|main\.dart\.js|canvaskit/i);
    assert.match(html, /\/shavette\/app\.v1\.js/);
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
  });

  it("stays below a 120 KB source payload", () => {
    const files = [
      path.join(landingRoot, "index.html"),
      path.join(landingRoot, "styles.v1.css"),
      path.join(landingRoot, "app.v1.js"),
      path.join(projectRoot, "assets", "images", "shavette", "shavette_agenda.jpg"),
      path.join(projectRoot, "assets", "images", "shavette", "shavette_icon.jpg"),
    ];
    const totalBytes = files.reduce(
      (total, file) => total + fs.statSync(file).size,
      0,
    );

    assert.ok(totalBytes < 120_000, `Landing payload is ${totalBytes} bytes`);
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
          header.value.includes("frame-ancestors 'none'"),
      ),
    );
  });

  it("contains no inline scripts or styles blocked by the CSP", () => {
    assert.doesNotMatch(html, /<script(?![^>]*\bsrc=)[^>]*>/i);
    assert.doesNotMatch(html, /<style\b/i);
    assert.ok(css.length > 0);
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
    assert.doesNotMatch(termsHtml, /<script\b/i);
    assert.doesNotMatch(termsHtml, /<style\b/i);
    assert.ok(termsCss.length > 0);
    assert.ok(
      termsHeaders.headers.some(
        (header) =>
          header.key === "Content-Security-Policy" &&
          header.value.includes("script-src 'none'") &&
          header.value.includes("frame-ancestors 'none'"),
      ),
    );
  });
});
