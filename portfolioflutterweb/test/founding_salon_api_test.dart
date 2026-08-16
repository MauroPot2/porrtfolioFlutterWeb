import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolioflutterweb/pages/shavette/data/founding_salon_api.dart';

const _application = FoundingSalonApplication(
  salonName: 'Barber Club',
  city: 'Catanzaro',
  staffCount: 3,
  ownerName: 'Mario Rossi',
  email: 'mario@example.com',
  phone: '+39 333 123 4567',
  instagram: '@barberclub',
  bookingMethod: 'whatsapp_phone',
  privacyAccepted: true,
  utmSource: 'facebook',
  utmMedium: 'social',
  utmCampaign: 'founding-salons',
  utmTerm: null,
  utmContent: null,
  landingPath: '/shavette',
);

void main() {
  test('sends the application payload and returns its Firestore id', () async {
    final client = MockClient((request) async {
      expect(request.method, 'POST');
      expect(request.url.toString(), 'https://example.test/applications');

      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['salonName'], 'Barber Club');
      expect(body['staffCount'], 3);
      expect(body['utmSource'], 'facebook');
      expect(body['privacyAccepted'], true);
      expect(body['website'], '');

      return http.Response(
        jsonEncode({'ok': true, 'applicationId': 'application-123'}),
        201,
        headers: {'content-type': 'application/json'},
      );
    });
    final api = FoundingSalonApi(
      client: client,
      endpoint: 'https://example.test/applications',
    );

    expect(await api.submit(_application), 'application-123');
  });

  test('uses the safe backend error message', () async {
    final client = MockClient(
      (_) async =>
          http.Response(jsonEncode({'message': 'Email non valida.'}), 400),
    );
    final api = FoundingSalonApi(
      client: client,
      endpoint: 'https://example.test/applications',
    );

    await expectLater(
      api.submit(_application),
      throwsA(
        isA<FoundingSalonApiException>().having(
          (error) => error.message,
          'message',
          'Email non valida.',
        ),
      ),
    );
  });
}
