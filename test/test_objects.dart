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

  static getFuturePrice() {
    BaseModel<Price> priceBaseModel = BaseModel()..setData(TestObjects.price);
    var completer = new Completer<BaseModel<Price>>();
    completer.complete(priceBaseModel);
    Future<BaseModel<Price>> priceModel = completer.future;
    return priceModel;
  }

  static Future<Ticket> getFutureTicket() {
    BaseModel<Price> priceBaseModel = BaseModel()..setData(TestObjects.price);
    var ticketExpected = TestObjects.ticket..setPrice(priceBaseModel.data);
    var completer = new Completer<Ticket>();
    completer.complete(ticketExpected);
    Future<Ticket> expectedFuture = completer.future;
    return expectedFuture;
  }

  static getFuturePriceError() {
    BaseModel<Price> priceBaseModel = BaseModel()
      ..setException(
          ServerError.withError(error: DioError(type: DioErrorType.CANCEL)));
    var completer = new Completer<BaseModel<Price>>();
    completer.complete(priceBaseModel);
    Future<BaseModel<Price>> priceModel = completer.future;
    return priceModel;
  }
}
