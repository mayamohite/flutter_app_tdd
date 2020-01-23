import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:test/test.dart';

import 'json_objects.dart';

void main() {
  test('Price null check', () {
    final price = Price.fromJson(null);
    expect(null, null);
  });

  test('Price from Json', () {
    final price = Price.fromJson(JsonObjects.price);
    expect(price, isNotNull);
    //Price actual = Price(3560, 37, "INR", "6E-ARI", "DEL", "CHE"); //ToDo check price.fromJson object to Price() object
  });

}
