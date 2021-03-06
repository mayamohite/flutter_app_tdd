import 'package:flutter_app_tdd/data/models/ticket_detail_models/airline.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:test/test.dart';
import '../data_setup/json_objects.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_app_tdd/core/network/server_error.dart';

void main() {
  test('Check ticket is null', () {
    final ticket = Ticket.fromJson(null);
    expect(null, null);
  });

  test('Ticket from Json', () {
    final ticket = Ticket.fromJson(JsonObjects.ticket);
    expect(ticket, isNotNull);
  });

  test('Check Airline nullability from Ticket Json', () {
    final ticket = Ticket.fromJson(JsonObjects.ticket);
    expect(ticket.airline, isNotNull);
  });

  test('Check Price nullability from Ticket Json', () {
    final ticket = Ticket.fromJson(JsonObjects.ticket);
    expect(ticket.price, null);
  });

  test('Check Price is not null in Ticket', () {
    final ticket = Ticket.fromJson(JsonObjects.ticket);
    final price = Price.fromJson(JsonObjects.price);
    ticket.setPrice(price);
    expect(ticket.price, isNotNull);
    expect(ticket.isPriceError, false);
  });

  test('Check Price Error in Ticket', () {
    final ticket = Ticket.fromJson(JsonObjects.ticket);
    final serverError = ServerError.withError(
        error: DioError(
            type: DioErrorType.RESPONSE,
            error: "404 error",
            response: Response(statusCode: 404)));
    ticket.setPriceError(serverError);
    expect(ticket.price, null);
    expect(ticket.isPriceError, true);
  });

  test('Check Ticket object equality', () {
    final actualTicket = Ticket.fromJson(JsonObjects.ticket);
    final actualAirline = Airline(
        id: 1103,
        name: "Spicejet",
        logo: "https:\/\/api.androidhive.info\/json\/images\/spicejet.png");

    final expectedTicket = Ticket(
        from: "DEL",
        to: "CHE",
        flightNumber: "AC-971",
        departure: "08:11",
        arrival: "10:59",
        duration: "2h 48m",
        instructions: "",
        numberOfStops: 1,
        airline: actualAirline);

    expect(actualTicket, expectedTicket);
  });
}
