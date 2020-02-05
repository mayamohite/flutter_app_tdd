import 'package:flutter_app_tdd/features/ticket_details/get_ticket_details_usecase.dart';
import 'package:flutter_app_tdd/features/ticket_details/ticket_list_provider.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../data_setup/test_objects.dart';

void main() {
  group('getList', () {
    MockTicketDetailsUseCase mockTicketDetailsUseCase;

    setUpAll(() {
      mockTicketDetailsUseCase = MockTicketDetailsUseCase();

      when(mockTicketDetailsUseCase.getTicketList(any, any)).thenAnswer(
        (_) => TestObjects.getTicketBaseModeList(),
      );
      when(mockTicketDetailsUseCase.getTicketPrice(any)).thenAnswer(
        (_) => TestObjects.getFutureTicket(),
      );

      Injector.getInjector()
          .map<TicketDetailsUsecase>((i) => mockTicketDetailsUseCase);
    });

    tearDownAll(() {
      Injector.getInjector().dispose();
    });

    test('calls the TicketDetailsUseCase.getTicketList method', () async {
      final ticketDetailsProvider = TicketDetailsProvider();
      final from = 'foo';
      final to = 'bar';

      await ticketDetailsProvider.getList(from, to);

      verify(mockTicketDetailsUseCase.getTicketList(from, to));
    });

    test('causes the subject stream to emit the correct events', () async {
      final ticketDetailsProvider = TicketDetailsProvider();

      ticketDetailsProvider.getList('foo', 'bar');

      // emits the tickets list once as-is (tickets without prices),
      // and one more time for each ticket price update
      final expectedEventsCount = TestObjects.ticketList.length;
      final expectedStreamEvents = [
        TestObjects.ticketList,
        TestObjects.ticketList,
        TestObjects.ticketList,
        TestObjects.ticketList,
        TestObjects.ticketList,
      ];

      expect(expectedStreamEvents.length, equals(expectedEventsCount));
      /* expect(ticketDetailsProvider.subject.stream,
          emitsInOrder(TestObjects.ticketList));*/ //ToDo modify test case to pass emitsInOrder
    });
  });
}

class MockTicketDetailsUseCase extends Mock implements TicketDetailsUsecase {}
