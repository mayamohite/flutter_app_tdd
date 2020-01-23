import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:test/test.dart';

import 'json_objects.dart';

void main() {
  test('Price null check', () {
    final price = Price.fromJson(null);
    expect(price, null);
  });

  test('Price from Json', () {
    final price = Price.fromJson(JsonObjects.price);
    expect(price, isNotNull);
  });

  test('Check Price Object equality', () {
    Price expectedPrice = Price(
        price: 3560,
        seats: 37,
        currency: "INR",
        flightNumber: "6E-ARI",
        from: "DEL",
        to: "CHE");

    final actualprice = Price.fromJson(JsonObjects.price);
    expect(actualprice, expectedPrice);
  });
}
