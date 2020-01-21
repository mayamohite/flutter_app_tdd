import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/repositories/ticket_detail_repository_impl.dart';
import 'package:flutter_app_tdd/features/ticket_details/get_ticket_details_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'test_objects.dart';

void main() {
  test('Get price success from Rest API', () async {
    final mockRepository = MockRepository();
    when(mockRepository.getTicketPrice("AC-971", "DEL", "CHE"))
        .thenAnswer((_) async => TestObjects.getFuturePrice());

    TicketDetailsUsecase ticketDetailsUsecase =
        TicketDetailsUsecase(repository: mockRepository);

    var actualFuture = await ticketDetailsUsecase.getTicketPrice(TestObjects.ticket);
    var expectedFuture = await TestObjects.getFutureTicket();

    int expected = expectedFuture.price.price;
    int actual = actualFuture.price.price;

    expect(actual, expected);
  });

  test('Get price failure from Rest API', () async {
    final mockRepository = MockRepository();
    when(mockRepository.getTicketPrice("AC-971", "DEL", "CHE"))
        .thenAnswer((_) async => TestObjects.getFuturePriceError());

    TicketDetailsUsecase ticketDetailsUsecase =
        TicketDetailsUsecase(repository: mockRepository);

    var actualFuture =
        await ticketDetailsUsecase.getTicketPrice(TestObjects.ticket);
    Price price = actualFuture.price;
    expect(price, null);
    expect(actualFuture.isPriceError, true);
  });
}

class MockRepository extends Mock implements RepositoryImpl {}
