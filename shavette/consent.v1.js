window.dataLayer = window.dataLayer || [];
function gtag() {
  dataLayer.push(arguments);
}

gtag('consent', 'default', {
  ad_storage: 'denied',
  analytics_storage: 'denied',
  ad_user_data: 'denied',
  ad_personalization: 'denied',
  wait_for_update: 500,
});

gtag('js', new Date());
gtag('config', 'AW-18503833834');

(function () {
  const storageKey = 'shavette_google_consent_v1';

  function applyConsent(granted, persist) {
    gtag('consent', 'update', {
      ad_storage: granted ? 'granted' : 'denied',
      analytics_storage: granted ? 'granted' : 'denied',
      ad_user_data: granted ? 'granted' : 'denied',
      ad_personalization: granted ? 'granted' : 'denied',
    });

    if (persist) {
      try {
        localStorage.setItem(storageKey, granted ? 'granted' : 'denied');
      } catch (_) {}
    }

    const banner = document.getElementById('consent-banner');
    if (banner) banner.hidden = true;
  }

  document.addEventListener('DOMContentLoaded', function () {
    const banner = document.getElementById('consent-banner');
    const acceptButton = document.getElementById('consent-accept');
    const rejectButton = document.getElementById('consent-reject');

    if (!banner || !acceptButton || !rejectButton) return;

    let savedConsent = null;
    try {
      savedConsent = localStorage.getItem(storageKey);
    } catch (_) {}

    if (savedConsent === 'granted') {
      applyConsent(true, false);
    } else if (savedConsent === 'denied') {
      applyConsent(false, false);
    } else {
      banner.hidden = false;
    }

    acceptButton.addEventListener('click', function () {
      applyConsent(true, true);
    });

    rejectButton.addEventListener('click', function () {
      applyConsent(false, true);
    });
  });
})();
