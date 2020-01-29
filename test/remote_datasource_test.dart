import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_app_tdd/core/network/api_client.dart';
import 'package:flutter_app_tdd/data/datasource/remote/remote_datasource.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_objects.dart';

void main() {
  MockApiClient apiClient;
  MockDio dio;
  RemoteDatasource remoteDatasource;

  setUp(() {
    apiClient = MockApiClient();
    dio = MockDio();
    remoteDatasource = new RemoteDatasource(dio: dio, apiClient: apiClient);
  });

  test('Get price from Rest API with success', () async {
    when(apiClient.getTicketPrice("AC-971", "DEL", "CHE"))
        .thenAnswer((_) async => TestObjects.getFuturePrice());
    var actualValue =
    await remoteDatasource.getTicketPrice("AC-971", "DEL", "CHE");
    expect(actualValue.data, isNotNull);
    expect(actualValue.getException, null);
  });

  /*test('Get price from Rest API with failure', () async {
    when(apiClient.getTicketPrice("AC-971", "DEL", "CHE")).thenThrow(DioError(
        type: DioErrorType.RESPONSE,
        error: "404 error",
        response: Response(statusCode: 404)));
    var actualValue =
    await remoteDatasource.getTicketPrice("AC-971", "DEL", "CHE");
    expect(actualValue.getException, isNotNull);
    expect(actualValue.data, null);
  });
*/
  test('Get Ticket List from Rest API with success', () async {
    when(apiClient.getFlightTickets("DEL", "CHE"))
        .thenAnswer((_) async => TestObjects.getFutureTickeList());
    var actualValue = await remoteDatasource.ticketList("DEL", "CHE");
    expect(actualValue.data.length, 5);
    //Todo
  });


  test('Get Ticket List from Rest API with failure', () async {
    when(apiClient.getFlightTickets("DEL", "CHE")).thenThrow(DioError(
        type: DioErrorType.RESPONSE,
        error: "404 error",
        response: Response(statusCode: 500)));

    var actualValue = await remoteDatasource.ticketList("DEL", "CHE");
    expect(actualValue.getException, isNotNull);
    expect(actualValue.data, null);
  });

  tearDown(() {
    apiClient = null;
    dio = null;
    remoteDatasource = null;
  });




}

class MockApiClient extends Mock implements ApiClient {}

class MockDio extends Mock implements Dio {}
