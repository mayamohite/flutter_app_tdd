import 'package:flutter_app_tdd/core/model/base_model.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';

abstract class Repository {
  Future<BaseModel<List<Ticket>>> getTicketList(String from, String to);

  Future<BaseModel<Price>> getTicketPrice(
      String flightNumber, String from, String to);
}
