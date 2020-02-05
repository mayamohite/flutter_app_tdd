import 'dart:ui';

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
    if (json == null || json.length == 0) {
      return null;
    }
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['flight_number'] = this.flightNumber;
    data['departure'] = this.departure;
    data['arrival'] = this.arrival;
    data['duration'] = this.duration;
    data['instructions'] = this.instructions;
    data['stops'] = this.numberOfStops;
    if (this.airline != null) {
      data['airline'] = this.airline.toJson();
    }
    return data;
  }

  setPrice(price) {
    this.price = price;
    isPriceError = false;
  }

  setPriceError(ServerError error) {
    this.price = null;
    isPriceError = true;
  }

  @override
  int get hashCode => hashValues(from, to, flightNumber, departure, arrival,
      duration, instructions, numberOfStops, airline, price, isPriceError);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType == other.runtimeType) return true;
    final Ticket otherTicket = other;
    return from == otherTicket.from &&
        to == otherTicket.to &&
        flightNumber == otherTicket.flightNumber &&
        departure == otherTicket.departure &&
        arrival == otherTicket.arrival &&
        duration == otherTicket.duration &&
        instructions == otherTicket.instructions &&
        numberOfStops == otherTicket.numberOfStops &&
        airline == otherTicket.airline &&
        price == otherTicket.price &&
        isPriceError == otherTicket.isPriceError;
  }
}
