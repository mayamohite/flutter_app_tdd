import 'package:flutter_app_tdd/data/models/ticket_detail_models/airline.dart';
import 'package:test/test.dart';
import '../data_setup/json_objects.dart';

void main() {
  test('Airline null check', () {
    final airline = Airline.fromJson(null);
    expect(airline, null);
  });

  test('Airline from json check', () {
    final airline = Airline.fromJson(JsonObjects.ticket['airline']);
    expect(airline, isNotNull);
  });

  test('Check Airline Object equality', () {
    Airline expectedAirline = Airline(
        id: 1103,
        name: "Spicejet",
        logo: "https:\/\/api.androidhive.info\/json\/images\/spicejet.png");

    final actualAirline = Airline.fromJson(JsonObjects.ticket['airline']);
    expect(actualAirline, expectedAirline);
  });

  test('Check Airline Object parameter nullability', () {
    Airline actualAirline = Airline.fromJson(JsonObjects.airline_without_parameters);
    expect(actualAirline.name, null);
    expect(actualAirline.id, null);
    expect(actualAirline.logo, null);
  });
}