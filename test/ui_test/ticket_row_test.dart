import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:flutter_app_tdd/features/ticket_details/ticket_row.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data_setup/test_objects.dart';

void main() {
  group('TicketView', () {
    setUpAll(() {
      // avoids crashes due to NetworkImageLoadExceptions on test environments
      HttpOverrides.global = null;
    });

    testWidgets('shows the airline name', (tester) async {
      final ticket = TestObjects.ticket;
      final airlineNameFinder = find.text(ticket.airline.name);

      await pumpTicketViewWidget(tester, ticket);

      expect(airlineNameFinder, findsOneWidget);
    });

    testWidgets('shows the departure time', (tester) async {
      final ticket = TestObjects.ticket;
      final departureTimeFinder = find.text('${ticket.departure} Dep');

      await pumpTicketViewWidget(tester, ticket);

      expect(departureTimeFinder, findsOneWidget);
    });

    testWidgets('shows the arrival time', (tester) async {
      final ticket = TestObjects.ticket;
      final arrivalTimeFinder = find.text('${ticket.arrival} Dest');

      await pumpTicketViewWidget(tester, ticket);

      expect(arrivalTimeFinder, findsOneWidget);
    });

    testWidgets('shows the number of stops', (tester) async {
      final ticket = TestObjects.ticket;
      final numberOfStopsFinder = find.text('${ticket.numberOfStops} stops');

      await pumpTicketViewWidget(tester, ticket);

      expect(numberOfStopsFinder, findsOneWidget);
    });

    testWidgets('shows price data if available', (tester) async {
      final price = TestObjects.price;
      final ticket = Ticket.fromJson(TestObjects.ticket.toJson());

      final seatsAvailableFinder = find.text("${price.seats} Seats");
      final currencyAndPriceFinder =
          find.text("${price.currency} ${price.price}");

      await pumpTicketViewWidget(tester, ticket);

      expect(seatsAvailableFinder, findsNothing);
      expect(currencyAndPriceFinder, findsNothing);

      ticket.setPrice(price);

      await pumpTicketViewWidget(tester, ticket);

      expect(seatsAvailableFinder, findsOneWidget);
      expect(currencyAndPriceFinder, findsOneWidget);
    });

    // TODO investigate - passes when run on its own, but fails when run from its enclosing group 🤷🏻‍♂️
    testWidgets('shows a loading indicator if no price data is available',
        (tester) async {
      final price = TestObjects.price;
      //This test case was failing as TestObject.ticket is static and already holds the value of price from previous test case.
      // So new instance of ticket is created from below line.
      final ticket = Ticket.fromJson(TestObjects.ticket.toJson());
      expect(ticket.price, null);

      final loadingIndicatorFinder = find.byType(SpinKitWave);

      await pumpTicketViewWidget(tester, ticket);

      expect(loadingIndicatorFinder, findsOneWidget);

      ticket.setPrice(price);

      await pumpTicketViewWidget(tester, ticket);

      expect(loadingIndicatorFinder, findsNothing);
    });
  });
}

/// Renders a [TicketView] widget wrapped for testing
Future<void> pumpTicketViewWidget(WidgetTester tester, Ticket ticket) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: TicketView(ticket: ticket),
      ),
    ),
  );
}
