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

import 'constants.dart';
import 'test_objects.dart';

/* When - ThenReturn  - Object
 When - ThenAnswer -  Future/Stream
* */
void main() {
  MockTicketDetailsUseCase mockTicketDetailsUseCase;

  setUp(() {
    print("setup called");
    mockTicketDetailsUseCase = MockTicketDetailsUseCase();
    //Do not remove dispose as the injectors needs to reinitialize for every test cases out there in this main function.
    Injector.getInjector().dispose();
    ModuleContainer().initialise(Injector.getInjector(),
        ticketDetailsUsecase: mockTicketDetailsUseCase);
  });

  group("Flight Tickets success failure testings", (){
    testWidgets('Success fetching Tickets and prices UI test', (WidgetTester tester) async {
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
      expect(find.byKey(Key(LOADER_LIST_KEY)), findsOneWidget);
      expect(find.text('Flight Tickets'), findsOneWidget);
      await tester.pump(Duration(milliseconds: FETCH_DELAYED_IDEAL_DURATION));
      expect(find.byKey(Key(LIST_KEY)), findsOneWidget);
      await tester.pump(Duration(milliseconds: FETCH_DELAYED_IDEAL_DURATION));
      expect(find.byKey(Key('price${TestObjects.ticketList[0].flightNumber}')),
          findsOneWidget);
    });


    testWidgets('Failure fetching Tickets and prices UI test', (WidgetTester tester) async {
      when(mockTicketDetailsUseCase.getTicketList("DEL", "CHE"))
          .thenAnswer((_) async => TestObjects.getFutureTicketBaseModelListError());

      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: TicketList(),
        ),
      );
      expect(find.byKey(Key(LOADER_LIST_KEY)), findsOneWidget);
      expect(find.text('Flight Tickets'), findsOneWidget);
      await tester.pump(Duration(milliseconds: FETCH_DELAYED_IDEAL_DURATION));
      expect(find.byKey(Key(LIST_KEY)), findsNothing);
      await tester.pump(Duration(milliseconds: FETCH_DELAYED_IDEAL_DURATION));
      expect(find.byKey(Key(ERROR_VIEW_KEY)), findsOneWidget);
    });
  });
}

class MockTicketDetailsUseCase extends Mock implements TicketDetailsUsecase {}
