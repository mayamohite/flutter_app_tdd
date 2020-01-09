import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/core/network/api_client.dart';
import 'package:flutter_app_tdd/core/network/server_error.dart';
import 'package:flutter_app_tdd/core/model/base_model.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';

class RemoteDatasource {
  final Dio dio;
  final ApiClient apiClient;

  RemoteDatasource({@required this.dio, @required this.apiClient});

  Future<BaseModel<List<Ticket>>> ticketList(String from, String to) async {
    List<Ticket> response;
    try {
      response = await apiClient.getFlightTickets(from, to);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<Price>> getTicketPrice(
      String flightNumber, String from, String to) async {
    Price response;
    try {
      response = await apiClient.getTicketPrice(flightNumber, from, to);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
