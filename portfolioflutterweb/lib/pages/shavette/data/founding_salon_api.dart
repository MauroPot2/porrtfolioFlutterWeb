import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const _defaultEndpoint =
    'https://europe-west1-shavette-16c2f.cloudfunctions.net/'
    'submitFoundingSalonApplication';

class FoundingSalonApplication {
  const FoundingSalonApplication({
    required this.salonName,
    required this.city,
    required this.staffCount,
    required this.ownerName,
    required this.email,
    required this.phone,
    required this.instagram,
    required this.bookingMethod,
    required this.privacyAccepted,
    required this.utmSource,
    required this.utmMedium,
    required this.utmCampaign,
    required this.utmTerm,
    required this.utmContent,
    required this.landingPath,
  });

  final String salonName;
  final String city;
  final int staffCount;
  final String ownerName;
  final String email;
  final String phone;
  final String instagram;
  final String bookingMethod;
  final bool privacyAccepted;
  final String? utmSource;
  final String? utmMedium;
  final String? utmCampaign;
  final String? utmTerm;
  final String? utmContent;
  final String landingPath;

  Map<String, Object?> toJson() {
    return {
      'salonName': salonName.trim(),
      'city': city.trim(),
      'staffCount': staffCount,
      'ownerName': ownerName.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'instagram': instagram.trim(),
      'bookingMethod': bookingMethod,
      'privacyAccepted': privacyAccepted,
      'privacyPolicyVersion': '2026-08-15-founding-salons',
      'utmSource': utmSource,
      'utmMedium': utmMedium,
      'utmCampaign': utmCampaign,
      'utmTerm': utmTerm,
      'utmContent': utmContent,
      'landingPath': landingPath,
      // Campo esca: deve restare vuoto. Il backend scarta i bot che lo
      // valorizzano automaticamente.
      'website': '',
    };
  }
}

class FoundingSalonApiException implements Exception {
  const FoundingSalonApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FoundingSalonApi {
  FoundingSalonApi({
    http.Client? client,
    String endpoint = const String.fromEnvironment(
      'SHAVETTE_FOUNDING_SALONS_ENDPOINT',
      defaultValue: _defaultEndpoint,
    ),
  }) : _client = client ?? http.Client(),
       _endpoint = Uri.parse(endpoint);

  final http.Client _client;
  final Uri _endpoint;

  Future<String> submit(FoundingSalonApplication application) async {
    late http.Response response;

    try {
      response = await _client
          .post(
            _endpoint,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(application.toJson()),
          )
          .timeout(const Duration(seconds: 18));
    } on TimeoutException {
      throw const FoundingSalonApiException(
        'La richiesta sta impiegando troppo tempo. Riprova tra poco.',
      );
    } on http.ClientException {
      throw const FoundingSalonApiException(
        'Non riesco a raggiungere il servizio. Controlla la connessione e '
        'riprova.',
      );
    }

    Map<String, Object?> payload = const {};
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        payload = decoded;
      }
    } on FormatException {
      // Un errore HTML del proxy non deve essere mostrato nel dettaglio.
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = payload['message'];
      throw FoundingSalonApiException(
        message is String && message.trim().isNotEmpty
            ? message
            : 'Non è stato possibile inviare la candidatura. Riprova.',
      );
    }

    final applicationId = payload['applicationId'];
    if (applicationId is! String || applicationId.isEmpty) {
      throw const FoundingSalonApiException(
        'La candidatura non è stata confermata. Riprova.',
      );
    }

    return applicationId;
  }
}
