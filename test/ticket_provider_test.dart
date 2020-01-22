import 'package:flutter_app_tdd/features/ticket_details/get_ticket_details_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  MockTicketDetailsUsecase mockTicketDetailsUsecase;
  setUp(() {
    mockTicketDetailsUsecase = MockTicketDetailsUsecase();
  });

  test('Get ticket List', () async {


  });
}

class MockTicketDetailsUsecase extends Mock implements TicketDetailsUsecase {}
