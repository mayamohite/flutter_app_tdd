import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/core/model/base_model.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'get_ticket_details_usecase.dart';

class TicketDetailsProvider with ChangeNotifier {
  TicketDetailsUsecase _ticketDetailsUsecase;
  final BehaviorSubject<List<Ticket>> _subject =
      BehaviorSubject<List<Ticket>>();

  BehaviorSubject<List<Ticket>> get subject => _subject;

  TicketDetailsProvider() {
    _ticketDetailsUsecase = Injector.getInjector().get<TicketDetailsUsecase>();

    _subject.listen((ticketList) {
      Stream.fromIterable(ticketList).flatMap(
            (ticket) {
          _ticketDetailsUsecase
              .getTicketPrice(ticket.flightNumber, ticket.from, ticket.to)
              .then(
                (onValue) {
              if (onValue.data != null)
                ticket.setPrice(onValue.data);
              else
                ticket.setPriceError(onValue.getException);
            },
          );
          return Stream.empty();
        },
      ).listen((onDone) => {print("On Done  : ${onDone}")});
    });
  }

  getList(String from, String to) async {
    BaseModel<List<Ticket>> ticketList =
        await _ticketDetailsUsecase.getTicketList(from, to);

    if (ticketList.data != null) {
      _subject.sink.add(ticketList.data);
    } else {
      _subject.addError(ticketList.getException);
    }
  }

  dispose() => _subject.close();
}
