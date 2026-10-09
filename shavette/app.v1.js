'use strict';

(function () {
  const ENDPOINT =
    'https://europe-west1-shavette-16c2f.cloudfunctions.net/' +
    'submitFoundingSalonApplication';
  const PRIVACY_VERSION = '2026-08-15-founding-salons';
  const REQUEST_TIMEOUT_MS = 18000;

  const form = document.getElementById('founding-salon-form');
  const errorBox = document.getElementById('form-error');
  const submitButton = document.getElementById('submit-button');
  const successMessage = document.getElementById('success-message');
  const newApplicationButton = document.getElementById('new-application');

  if (!form || !errorBox || !submitButton || !successMessage) {
    return;
  }

  let formStartedAt = Date.now();
  let isSubmitting = false;

  function queryValue(name) {
    const value = new URLSearchParams(window.location.search).get(name);
    if (!value) return null;
    const normalized = value.trim();
    return normalized ? normalized.slice(0, 120) : null;
  }

  function showError(message) {
    errorBox.textContent = message;
    errorBox.hidden = false;
    errorBox.scrollIntoView({ behavior: 'smooth', block: 'center' });
  }

  function clearError() {
    errorBox.textContent = '';
    errorBox.hidden = true;
  }

  function setSubmitting(value) {
    isSubmitting = value;
    submitButton.disabled = value;
    submitButton.classList.toggle('is-loading', value);
    form.setAttribute('aria-busy', String(value));

    form.querySelectorAll('input, select').forEach(function (control) {
      control.disabled = value;
    });
  }

  function payloadFromForm() {
    const data = new FormData(form);

    return {
      salonName: String(data.get('salonName') || '').trim(),
      city: String(data.get('city') || '').trim(),
      staffCount: Number(data.get('staffCount')),
      ownerName: String(data.get('ownerName') || '').trim(),
      email: String(data.get('email') || '').trim(),
      phone: String(data.get('phone') || '').trim(),
      instagram: String(data.get('instagram') || '').trim(),
      bookingMethod: String(data.get('bookingMethod') || ''),
      privacyAccepted: data.get('privacyAccepted') === 'on',
      privacyPolicyVersion: PRIVACY_VERSION,
      utmSource: queryValue('utm_source'),
      utmMedium: queryValue('utm_medium'),
      utmCampaign: queryValue('utm_campaign'),
      utmTerm: queryValue('utm_term'),
      utmContent: queryValue('utm_content'),
      landingPath: window.location.pathname,
      formStartedAt: formStartedAt,
      formVersion: 'static-2026-08-16-v1',
      website: String(data.get('website') || '').trim(),
    };
  }

  async function parseResponse(response) {
    try {
      return await response.json();
    } catch (_) {
      return {};
    }
  }

  async function submitApplication(payload) {
    const controller = new AbortController();
    const timeout = window.setTimeout(function () {
      controller.abort();
    }, REQUEST_TIMEOUT_MS);

    try {
      const response = await fetch(ENDPOINT, {
        method: 'POST',
        mode: 'cors',
        credentials: 'omit',
        cache: 'no-store',
        referrerPolicy: 'strict-origin-when-cross-origin',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
        signal: controller.signal,
      });

      const result = await parseResponse(response);
      if (!response.ok) {
        const fallback = response.status === 429
          ? 'Sono arrivate troppe richieste. Attendi qualche minuto e riprova.'
          : 'Non è stato possibile inviare la candidatura. Riprova.';
        throw new Error(
          typeof result.message === 'string' && result.message.trim()
            ? result.message
            : fallback,
        );
      }

      if (!result.applicationId) {
        throw new Error('La candidatura non è stata confermata. Riprova.');
      }
    } catch (error) {
      if (error && error.name === 'AbortError') {
        throw new Error(
          'La richiesta sta impiegando troppo tempo. Controlla la connessione e riprova.',
        );
      }

      if (error instanceof TypeError) {
        throw new Error(
          'Non riesco a raggiungere il servizio. Controlla la connessione e riprova.',
        );
      }

      throw error;
    } finally {
      window.clearTimeout(timeout);
    }
  }

  form.addEventListener('submit', async function (event) {
    event.preventDefault();
    if (isSubmitting) return;

    clearError();
    form.classList.add('was-validated');

    if (!form.checkValidity()) {
      form.reportValidity();
      return;
    }

    const payload = payloadFromForm();
    const phoneDigits = payload.phone.replace(/\D/g, '');
    if (phoneDigits.length < 7 || phoneDigits.length > 15) {
      showError('Inserisci un numero di telefono valido.');
      return;
    }

    setSubmitting(true);

    try {
      await submitApplication(payload);
      form.hidden = true;
      successMessage.hidden = false;
      successMessage.focus({ preventScroll: true });
      successMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
    } catch (error) {
      showError(
        error instanceof Error
          ? error.message
          : 'Si è verificato un problema inatteso. Riprova tra poco.',
      );
    } finally {
      setSubmitting(false);
    }
  });

  if (newApplicationButton) {
    newApplicationButton.addEventListener('click', function () {
      form.reset();
      form.classList.remove('was-validated');
      clearError();
      formStartedAt = Date.now();
      successMessage.hidden = true;
      form.hidden = false;
      const firstField = form.querySelector('input:not([tabindex="-1"])');
      if (firstField) firstField.focus();
    });
  }
})();
