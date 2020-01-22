import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/repositories/ticket_detail_repository_impl.dart';
import 'package:flutter_app_tdd/features/ticket_details/get_ticket_details_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'test_objects.dart';

void main() {
  MockRepository mockRepository;
  TicketDetailsUsecase ticketDetailsUsecase;

  setUp(() {
    mockRepository = MockRepository();
    ticketDetailsUsecase = TicketDetailsUsecase(repository: mockRepository);
  });

  test('Get price success from Rest API', () async {
    when(mockRepository.getTicketPrice("AC-971", "DEL", "CHE"))
        .thenAnswer((_) async => TestObjects.getFuturePriceBaseModel());
    var actualFuture =
        await ticketDetailsUsecase.getTicketPrice(TestObjects.ticket);
    var expectedFuture = await TestObjects.getFutureTicket();
    int expected = expectedFuture.price.price;
    int actual = actualFuture.price.price;
    expect(actual, expected);
  });

  test('Get price failure from Rest API', () async {
    when(mockRepository.getTicketPrice("AC-971", "DEL", "CHE"))
        .thenAnswer((_) async => TestObjects.getFuturePriceBaseModelError());
    var actualFuture =
        await ticketDetailsUsecase.getTicketPrice(TestObjects.ticket);
    Price price = actualFuture.price;
    expect(price, null);
    expect(actualFuture.isPriceError, true);
  });

  test('get Ticket List success from Rest API', () async {
    when(mockRepository.getTicketList("DEL", "CHE"))
        .thenAnswer((_) async => TestObjects.getTicketBaseModeList());
    var actualValue = await ticketDetailsUsecase.getTicketList("DEL", "CHE");
    expect(actualValue.data.length, 5);
    expect(actualValue.data, isNotNull);
    expect(actualValue.getException, null);
  });

  test('get Ticket List failure from Rest API', () async {
    when(mockRepository.getTicketList("DEL", "CHE")).thenAnswer(
        (_) async => TestObjects.getFutureTicketBaseModelListError());
    var actualValue = await ticketDetailsUsecase.getTicketList("DEL", "CHE");
    expect(actualValue.data, null);
    expect(actualValue.getException, isNotNull);
  });

  tearDown(() {

    mockRepository = null;
    ticketDetailsUsecase = null;
  });
}

class MockRepository extends Mock implements RepositoryImpl {}
