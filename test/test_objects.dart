import 'dart:async';

import 'package:flutter_app_tdd/core/model/base_model.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:flutter_app_tdd/core/network/server_error.dart';
import 'package:dio/dio.dart' hide Headers;
import 'constants.dart';
import 'json_objects.dart';

class TestObjects {
  static Ticket ticket = Ticket.fromJson(JsonObjects.ticket);
  static Price price = Price.fromJson(JsonObjects.price);
  static List<Ticket> ticketList =
      JsonObjects.ticket_list.map((dynamic i) => Ticket.fromJson(i as Map<String, dynamic>)).toList();

  static Future<BaseModel<Price>> getFuturePriceBaseModel() async{
    await Future.delayed(Duration(milliseconds: FETCH_DELAYED_DURATION));
    return BaseModel()..setData(price);
  }

  static Future<BaseModel<Price>> getFuturePriceBaseModelError() async {
    await Future.delayed(Duration(milliseconds: FETCH_DELAYED_DURATION));
    return BaseModel()..setException(ServerError.withError(error: DioError(type: DioErrorType.CANCEL)));
  }

  static Future<Price> getFuturePrice() async {
    await Future.delayed(Duration(milliseconds: FETCH_DELAYED_DURATION));
    return price;
  }

  static Future<Ticket> getFutureTicket() async {
    await Future.delayed(Duration(milliseconds: FETCH_DELAYED_DURATION));
    return ticket..setPrice(price);
  }

  static Future<List<Ticket>> getFutureTicketList() async {
    await Future.delayed(Duration(milliseconds: FETCH_DELAYED_DURATION));
    return ticketList;
  }

  static Future<BaseModel<List<Ticket>>> getTicketBaseModeList() async {
    await Future.delayed(Duration(milliseconds: FETCH_DELAYED_DURATION));
    return BaseModel()..setData(ticketList);
  }

  static Future<BaseModel<List<Ticket>>> getFutureTicketBaseModelListError() async {
    await Future.delayed(Duration(milliseconds: FETCH_DELAYED_DURATION));
    return BaseModel()..setException(ServerError.withError(error: DioError(type: DioErrorType.CANCEL)));
  }
}
