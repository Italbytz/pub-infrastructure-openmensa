import 'package:flutter_test/flutter_test.dart';

import 'package:open_mensa_infrastructure/open_mensa_infrastructure.dart';
import 'package:open_mensa_infrastructure/src/open_mensa_api.dart';

void main() {
  test('get canteents', () async {
    final api = OpenMensaAPI();
    var canteens = await api.getCanteens();
    expect(canteens.isNotEmpty, true);
  });

  test('get days', () async {
    final api = OpenMensaAPI();
    var days = await api.getDays(42);
    expect(days.isNotEmpty, true);
  });

  test('get meals', () async {
    final api = OpenMensaAPI();
    await api.getMeals(42, DateTime.now()).onError((error, stackTrace) {
      if (!(error is NoMealsForDateException ||
          error is MensaClosedException)) {
        fail("Unexpected Error $error");
      }
      return [];
    }).then((value) => expect(value.isNotEmpty, true));
  });
}
