import 'package:flutter_app_tdd/core/network/server_error.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/price.dart';

import 'package:flutter_app_tdd/data/models/ticket_detail_models/airline.dart';

class Ticket {
  String from;
  String to;
  String flightNumber;
  String departure;
  String arrival;
  String duration;
  String instructions;
  int numberOfStops;
  Airline airline;
  Price price;
  bool isPriceError = false;

  Ticket({
    this.from,
    this.to,
    this.flightNumber,
    this.departure,
    this.arrival,
    this.duration,
    this.instructions,
    this.numberOfStops,
    this.airline,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        from: json["from"],
        to: json["to"],
        flightNumber: json["flight_number"],
        departure: json["departure"],
        arrival: json["arrival"],
        duration: json["duration"],
        instructions: json["instructions"],
        numberOfStops: json["stops"],
        airline: Airline.fromJson(json["airline"]));
  }

  setPrice(price) {
    this.price = price;
    isPriceError = false;
  }

  setPriceError(ServerError error) {
    this.price = null;
    isPriceError = true;
  }
}
