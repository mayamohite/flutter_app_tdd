import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/core/model/base_model.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:flutter_app_tdd/domain/repositories/ticket_detail_repository.dart';
import 'package:flutter_app_tdd/data/datasource/local/local_datasource.dart';
import 'package:flutter_app_tdd/data/datasource/remote/remote_datasource.dart';

class RepositoryImpl extends Repository {
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;

  RepositoryImpl(
      {@required this.localDatasource, @required this.remoteDatasource});

  @override
  Future<BaseModel<List<Ticket>>> getTicketList(String from, String to) {
    return remoteDatasource.ticketList(from, to);
  }

  @override
  Future<BaseModel<Price>> getTicketPrice(
      String flightNumber, String from, String to) {
    return remoteDatasource.getTicketPrice(flightNumber, from, to);
  }
}
