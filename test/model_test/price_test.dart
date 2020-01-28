import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:test/test.dart';

import '../data_setup/json_objects.dart';

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

  test('Check Price Object parameters equality', () {
    Price actualprice = Price.fromJson(JsonObjects.price_without_parameters);
    expect(actualprice.price, null);
    expect(actualprice.seats, null);
    expect(actualprice.currency, null);
    expect(actualprice.flightNumber, isNotNull);
    expect(actualprice.from, null);
    expect(actualprice.to, null);
  });
}
