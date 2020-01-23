import 'dart:ui';

class Price {
  int price;
  int seats;
  String currency;
  String flightNumber;
  String from;
  String to;

  Price(
      {this.price,
      this.seats,
      this.currency,
      this.flightNumber,
      this.from,
      this.to});

  factory Price.fromJson(Map<String, dynamic> json) {
    if (json == null || json.length == 0) {
      return null;
    }
    return Price(
      price: json["price"],
      seats: json["seats"],
      currency: json["currency"],
      flightNumber: json["flight_number"],
      from: json["from"],
      to: json["to"],
    );
  }

  @override
  int get hashCode =>
      hashValues(price, seats, currency, flightNumber, from, to);

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    final Price otherPrice = other;
    return price == otherPrice.price &&
        seats == otherPrice.seats &&
        currency == otherPrice.currency &&
        flightNumber == otherPrice.flightNumber &&
        from == otherPrice.from &&
        to == otherPrice.to;
  }
}
