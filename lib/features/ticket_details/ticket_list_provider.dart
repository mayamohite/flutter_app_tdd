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
  }

  Stream<Ticket> getTicketPrice(ticket) {
    return Stream.fromFuture(_ticketDetailsUsecase.getTicketPrice(ticket));
  }

  getList(String from, String to) async {
    BaseModel<List<Ticket>> ticketList =
        await _ticketDetailsUsecase.getTicketList(from, to);

    if (ticketList.data != null) {
      _subject.sink.add(ticketList.data);

      Stream<Ticket> updatedTicket =
          Stream.fromIterable(ticketList.data).flatMap((tk) {
        return getTicketPrice(tk);
      });
      updatedTicket.listen((onData) {
        print("Future Data ${onData.flightNumber}");
        _subject.sink.add(ticketList.data);
      }, onError: (error) {
        print("Future Error");
        _subject.sink.add(ticketList.data);
      }, onDone: () {
        print("Future Done");
        ticketList.data.forEach((i) => {
              //ToDo we are getting updated data here
            });
      });
    } else {
      _subject.addError(ticketList.getException);
    }
  }

  dispose() => _subject.close();
}
