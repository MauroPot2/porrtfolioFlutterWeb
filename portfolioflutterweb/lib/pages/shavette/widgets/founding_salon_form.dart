import 'package:flutter/material.dart';
import 'package:portfolioflutterweb/pages/shavette/data/founding_salon_api.dart';
import 'package:url_launcher/url_launcher.dart';

const _privacyPolicyUrl =
    'https://docs.google.com/document/d/e/'
    '2PACX-1vQIY9lynkZMX9JqLDklxBqGL1sYw7JAzVOU5Gj9d6tsX8EHhLtMzVCT4RFvh2j_'
    'O4CJEwYpDqECa0hC/pub';

const _bookingMethods = <String, String>{
  'whatsapp_phone': 'WhatsApp / telefono',
  'paper_agenda': 'Agenda cartacea',
  'google_calendar': 'Google Calendar',
  'other_software': 'Altro gestionale',
  'no_system': 'Non utilizzo un sistema preciso',
};

class FoundingSalonForm extends StatefulWidget {
  const FoundingSalonForm({this.api, super.key});

  final FoundingSalonApi? api;

  @override
  State<FoundingSalonForm> createState() => _FoundingSalonFormState();
}

class _FoundingSalonFormState extends State<FoundingSalonForm> {
  final _formKey = GlobalKey<FormState>();
  final _salonNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _instagramController = TextEditingController();

  late final FoundingSalonApi _api;
  int? _staffCount;
  String? _bookingMethod;
  bool _privacyAccepted = false;
  bool _attemptedSubmit = false;
  bool _isSubmitting = false;
  bool _submitted = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _api = widget.api ?? FoundingSalonApi();
  }

  @override
  void dispose() {
    _salonNameController.dispose();
    _cityController.dispose();
    _ownerNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  String? _requiredText(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Inserisci $label';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final required = _requiredText(value, 'l’email');
    if (required != null) return required;

    final email = value!.trim();
    final valid = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    return valid ? null : 'Inserisci un indirizzo email valido';
  }

  String? _validatePhone(String? value) {
    final required = _requiredText(value, 'il numero di telefono');
    if (required != null) return required;

    final digits = value!.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 7 || digits.length > 15) {
      return 'Inserisci un numero di telefono valido';
    }
    return null;
  }

  InputDecoration _decoration({
    required String label,
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon, size: 21),
      filled: true,
      fillColor: const Color(0xFFF8FAFF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFDCE4F2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFDCE4F2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF2F80ED), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFC62828)),
      ),
    );
  }

  String? _queryParameter(String key) {
    final value = Uri.base.queryParameters[key]?.trim();
    return value == null || value.isEmpty ? null : value;
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    setState(() {
      _attemptedSubmit = true;
      _errorMessage = null;
    });

    final formIsValid = _formKey.currentState?.validate() ?? false;
    if (!formIsValid) return;

    setState(() => _isSubmitting = true);

    final application = FoundingSalonApplication(
      salonName: _salonNameController.text,
      city: _cityController.text,
      staffCount: _staffCount!,
      ownerName: _ownerNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      instagram: _instagramController.text,
      bookingMethod: _bookingMethod!,
      privacyAccepted: _privacyAccepted,
      utmSource: _queryParameter('utm_source'),
      utmMedium: _queryParameter('utm_medium'),
      utmCampaign: _queryParameter('utm_campaign'),
      utmTerm: _queryParameter('utm_term'),
      utmContent: _queryParameter('utm_content'),
      landingPath: Uri.base.path,
    );

    try {
      await _api.submit(application);
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _submitted = true;
      });
    } on FoundingSalonApiException catch (error) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorMessage = error.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorMessage =
            'Si è verificato un problema inatteso. Riprova tra poco.';
      });
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    _salonNameController.clear();
    _cityController.clear();
    _ownerNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _instagramController.clear();

    setState(() {
      _staffCount = null;
      _bookingMethod = null;
      _privacyAccepted = false;
      _attemptedSubmit = false;
      _submitted = false;
      _errorMessage = null;
    });
  }

  Future<void> _openPrivacyPolicy() async {
    await launchUrl(
      Uri.parse(_privacyPolicyUrl),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      child: _submitted ? _buildSuccess() : _buildForm(),
    );
  }

  Widget _buildSuccess() {
    return Semantics(
      liveRegion: true,
      child: Container(
        key: const ValueKey('success'),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFDCE4F2)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x140F2154),
              blurRadius: 32,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F8F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 42,
                color: Color(0xFF128455),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Candidatura ricevuta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                height: 1.1,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.7,
                color: Color(0xFF111B43),
              ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: const Text(
                'Grazie per esserti candidato come Shavette Founding Salon. '
                'Stiamo selezionando i primi 20 saloni e ti contatteremo '
                'all’indirizzo indicato.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  height: 1.55,
                  color: Color(0xFF56627A),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: _reset,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Invia un’altra candidatura'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      key: const ValueKey('form'),
      width: double.infinity,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2F80ED), Color(0xFF75A7F7)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color(0x242F80ED),
            blurRadius: 40,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: _attemptedSubmit
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FormHeading(
                eyebrow: 'IL TUO SALONE',
                title: 'Raccontaci chi sei',
                description:
                    'Bastano meno di due minuti. Ti ricontatteremo noi.',
              ),
              const SizedBox(height: 26),
              _ResponsiveFieldRow(
                children: [
                  TextFormField(
                    controller: _salonNameController,
                    enabled: !_isSubmitting,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.organizationName],
                    decoration: _decoration(
                      label: 'Nome del salone *',
                      hint: 'Es. Barber Club',
                      icon: Icons.storefront_outlined,
                    ),
                    validator: (value) =>
                        _requiredText(value, 'il nome del salone'),
                  ),
                  TextFormField(
                    controller: _cityController,
                    enabled: !_isSubmitting,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.addressCity],
                    decoration: _decoration(
                      label: 'Città *',
                      hint: 'Es. Catanzaro',
                      icon: Icons.location_on_outlined,
                    ),
                    validator: (value) => _requiredText(value, 'la città'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              DropdownButtonFormField<int>(
                initialValue: _staffCount,
                isExpanded: true,
                decoration: _decoration(
                  label: 'Numero di barbieri *',
                  icon: Icons.groups_2_outlined,
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('1 barbiere')),
                  DropdownMenuItem(value: 2, child: Text('2 barbieri')),
                  DropdownMenuItem(value: 3, child: Text('3 barbieri')),
                  DropdownMenuItem(value: 4, child: Text('4 o più barbieri')),
                ],
                onChanged: _isSubmitting
                    ? null
                    : (value) => setState(() => _staffCount = value),
                validator: (value) =>
                    value == null ? 'Seleziona il numero di barbieri' : null,
              ),
              const SizedBox(height: 34),
              const _FormHeading(
                eyebrow: 'TU',
                title: 'Come possiamo contattarti?',
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _ownerNameController,
                enabled: !_isSubmitting,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                decoration: _decoration(
                  label: 'Nome e cognome *',
                  icon: Icons.person_outline_rounded,
                ),
                validator: (value) => _requiredText(value, 'nome e cognome'),
              ),
              const SizedBox(height: 18),
              _ResponsiveFieldRow(
                children: [
                  TextFormField(
                    controller: _emailController,
                    enabled: !_isSubmitting,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    decoration: _decoration(
                      label: 'Email *',
                      hint: 'nome@email.it',
                      icon: Icons.mail_outline_rounded,
                    ),
                    validator: _validateEmail,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    enabled: !_isSubmitting,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    decoration: _decoration(
                      label: 'Telefono / WhatsApp *',
                      hint: '+39 333 123 4567',
                      icon: Icons.phone_outlined,
                    ),
                    validator: _validatePhone,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _instagramController,
                enabled: !_isSubmitting,
                textInputAction: TextInputAction.next,
                decoration: _decoration(
                  label: 'Instagram del salone',
                  hint: '@nomedelsalone',
                  icon: Icons.alternate_email_rounded,
                ),
              ),
              const SizedBox(height: 34),
              const _FormHeading(
                eyebrow: 'UNA SOLA DOMANDA',
                title: 'Come gestisci oggi le prenotazioni?',
              ),
              const SizedBox(height: 22),
              DropdownButtonFormField<String>(
                initialValue: _bookingMethod,
                isExpanded: true,
                decoration: _decoration(
                  label: 'Metodo attuale *',
                  icon: Icons.event_note_outlined,
                ),
                items: _bookingMethods.entries
                    .map(
                      (entry) => DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                    )
                    .toList(),
                onChanged: _isSubmitting
                    ? null
                    : (value) => setState(() => _bookingMethod = value),
                validator: (value) => value == null
                    ? 'Seleziona come gestisci le prenotazioni'
                    : null,
              ),
              const SizedBox(height: 22),
              FormField<bool>(
                initialValue: _privacyAccepted,
                validator: (value) => value == true
                    ? null
                    : 'Devi accettare il trattamento dei dati',
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: field.hasError
                                ? const Color(0xFFC62828)
                                : const Color(0xFFDCE4F2),
                          ),
                        ),
                        child: Material(
                          color: const Color(0xFFF8FAFF),
                          borderRadius: BorderRadius.circular(14),
                          child: CheckboxListTile(
                            value: _privacyAccepted,
                            enabled: !_isSubmitting,
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            activeColor: const Color(0xFF2F80ED),
                            title: const Text(
                              'Acconsento al trattamento dei dati per la '
                              'valutazione della candidatura e per essere '
                              'ricontattato. *',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: Color(0xFF36415A),
                              ),
                            ),
                            onChanged: _isSubmitting
                                ? null
                                : (value) {
                                    final accepted = value ?? false;
                                    setState(() {
                                      _privacyAccepted = accepted;
                                    });
                                    field.didChange(accepted);
                                  },
                          ),
                        ),
                      ),
                      if (field.hasError) ...[
                        const SizedBox(height: 7),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            field.errorText!,
                            style: const TextStyle(
                              color: Color(0xFFC62828),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: _openPrivacyPolicy,
                          child: const Text('Leggi l’informativa privacy'),
                        ),
                      ),
                    ],
                  );
                },
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Semantics(
                  liveRegion: true,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFECEC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          color: Color(0xFFC62828),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Color(0xFF8A1C1C),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2F80ED),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFF9DBCE5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 23,
                          height: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: Text('CANDIDA IL MIO SALONE')),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_rounded),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Nessuna carta richiesta. Nessun rinnovo automatico.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xFF69758D)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormHeading extends StatelessWidget {
  const _FormHeading({
    required this.eyebrow,
    required this.title,
    this.description,
  });

  final String eyebrow;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: Color(0xFF2F80ED),
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF111B43),
            fontSize: 24,
            height: 1.2,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 7),
          Text(
            description!,
            style: const TextStyle(color: Color(0xFF69758D), height: 1.45),
          ),
        ],
      ],
    );
  }
}

class _ResponsiveFieldRow extends StatelessWidget {
  const _ResponsiveFieldRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 660) {
          return Column(
            children: [
              for (var index = 0; index < children.length; index++) ...[
                children[index],
                if (index != children.length - 1) const SizedBox(height: 18),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var index = 0; index < children.length; index++) ...[
              Expanded(child: children[index]),
              if (index != children.length - 1) const SizedBox(width: 18),
            ],
          ],
        );
      },
    );
  }
}
