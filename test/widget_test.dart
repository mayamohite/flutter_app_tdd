// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:flutter_app_tdd/di/injector.dart';
import 'package:flutter_app_tdd/features/ticket_details/get_ticket_details_usecase.dart';
import 'package:flutter_app_tdd/features/ticket_details/ticket_list_widget.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_objects.dart';

/* When - ThenReturn  - Object
 When - ThenAnswer -  Future/Stream
* */
void main() {
  MockTicketDetailsUsecase mockTicketDetailsUseCase;

  setUp(() {
    mockTicketDetailsUseCase = MockTicketDetailsUsecase();
    ModuleContainer().initialise(Injector.getInjector(),
        ticketDetailsUsecase: mockTicketDetailsUseCase);
  });

  testWidgets('Basic UI test', (WidgetTester tester) async {
    var future = TestObjects.getTicketBaseModeList;
    when(mockTicketDetailsUseCase.getTicketList("DEL", "CHE"))
        .thenAnswer((_) async {
      var result = await future();

      for (int i = 0; i < result.data.length; i++) {
        var ticket = result.data[i];
        final ticketToRequest = ticket;
        when(mockTicketDetailsUseCase.getTicketPrice(ticketToRequest))
            .thenAnswer((Invocation invocation) async {
          final namedArgs = invocation.positionalArguments[0] as Ticket;
          namedArgs..price = TestObjects.price;
          return namedArgs;
        });
      }
      return result;
    });

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TicketList(),
      ),
    );
    expect(find.byKey(Key('Loader')), findsOneWidget);
    expect(find.text('Flight Tickets'), findsOneWidget);
    await tester.pump(Duration(milliseconds: 1000));
    expect(find.byKey(Key('list')), findsOneWidget);
    await tester.pump(Duration(milliseconds: 1000));
    expect(find.byKey(Key('price${TestObjects.ticketList[0].flightNumber}')),
        findsOneWidget);
  });
}

class MockTicketDetailsUsecase extends Mock implements TicketDetailsUsecase {}
