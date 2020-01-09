// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.androidhive.info/json';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getFlightTickets(from, to) async {
    ArgumentError.checkNotNull(from, 'from');
    ArgumentError.checkNotNull(to, 'to');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/airline-tickets.php?from=$from&to=$to',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Ticket.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  getTicketPrice(flightNumber, from, to) async {
    ArgumentError.checkNotNull(flightNumber, 'flightNumber');
    ArgumentError.checkNotNull(from, 'from');
    ArgumentError.checkNotNull(to, 'to');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/airline-tickets-price.php?flight_number=$flightNumber&from=$from&to=$to',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Price.fromJson(_result.data);
    return Future.value(value);
  }
}
