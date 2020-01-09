import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/core/model/base_model.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:flutter_app_tdd/data/repositories/ticket_detail_repository_impl.dart';

class TicketDetailsUsecase {
  final RepositoryImpl repository;

  TicketDetailsUsecase({@required this.repository});

  Future<BaseModel<List<Ticket>>> getTicketList(String from, String to) async {
    return repository.getTicketList(from, to);
  }

  Future<BaseModel<Price>> getTicketPrice(
      String flightNumber, String from, String to) async {
    return repository.getTicketPrice(flightNumber, from, to);
  }

  Stream<List<Ticket>> getList() {

  }
}
