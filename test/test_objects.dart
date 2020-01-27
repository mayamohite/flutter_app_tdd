import 'dart:async';

import 'package:flutter_app_tdd/core/model/base_model.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:flutter_app_tdd/core/network/server_error.dart';
import 'package:dio/dio.dart' hide Headers;
import 'json_objects.dart';

class TestObjects {
  static Ticket ticket = Ticket.fromJson(JsonObjects.ticket);
  static Price price = Price.fromJson(JsonObjects.price);
  static List<Ticket> ticketList = JsonObjects.ticket_list
      .map((dynamic i) => Ticket.fromJson(i as Map<String, dynamic>))
      .toList();

  static Future<BaseModel<Price>> getFuturePriceBaseModel() {
    BaseModel<Price> priceBaseModel = BaseModel()..setData(price);
    var completer = new Completer<BaseModel<Price>>();
    completer.complete(priceBaseModel);
    Future<BaseModel<Price>> priceModel = completer.future;
    return priceModel;
  }

  static Future<BaseModel<Price>> getFuturePriceBaseModelError() {
    BaseModel<Price> priceBaseModel = BaseModel()
      ..setException(
          ServerError.withError(error: DioError(type: DioErrorType.CANCEL)));
    var completer = new Completer<BaseModel<Price>>();
    completer.complete(priceBaseModel);
    Future<BaseModel<Price>> priceModel = completer.future;
    return priceModel;
  }
  
  static Future<Price> getFuturePrice() {
    var completer = new Completer<Price>();
    completer.complete(price);
    Future<Price> priceModel = completer.future;
    return priceModel;
  }

  static Future<Ticket> getFutureTicket() {
    BaseModel<Price> priceBaseModel = BaseModel()..setData(price);
    var ticketExpected = ticket..setPrice(priceBaseModel.data);
    var completer = new Completer<Ticket>();
    completer.complete(ticketExpected);
    Future<Ticket> expectedFuture = completer.future;
    return expectedFuture;
  }

  static Future<List<Ticket>> getFutureTickeList() {
    var completer = new Completer<List<Ticket>>();
    completer.complete(ticketList);
    Future<List<Ticket>> ticketListModel = completer.future;
    return ticketListModel;
  }

  static Future<BaseModel<List<Ticket>>> getTicketBaseModeList() async{
    await Future.delayed(Duration(milliseconds: 500));
    BaseModel<List<Ticket>> ticketListBaseModel = BaseModel()
      ..setData(ticketList);
    return ticketListBaseModel;
  }



  static Future<BaseModel<List<Ticket>>> getFutureTicketBaseModelListError() {
    BaseModel<List<Ticket>> ticketListBaseModel = BaseModel()
      ..setException(
          ServerError.withError(error: DioError(type: DioErrorType.CANCEL)));
    var completer = new Completer<BaseModel<List<Ticket>>>();
    completer.complete(ticketListBaseModel);
    Future<BaseModel<List<Ticket>>> ticketListModel = completer.future;
    return ticketListModel;
  }
}
