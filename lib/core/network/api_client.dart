import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:retrofit/http.dart';
import 'package:flutter_app_tdd/core/network/logger_interceptor.dart';

part 'package:flutter_app_tdd/core/network/api_client.g.dart';

@RestApi(baseUrl: "https://api.androidhive.info/json")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    dio.interceptors.add(LoggerInterceptor());
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET("/airline-tickets.php?from={from}&to={to}")
  Future<List<Ticket>> getFlightTickets(
      @Path("from") String from, @Path("to") String to);

  @GET("/airline-tickets-price.php?flight_number={flight_number}&from={from}&to={to}")
  Future<Price> getTicketPrice(@Path("flight_number") String flightNumber,
      @Path("from") String from, @Path("to") String to);
}
