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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['seats'] = this.seats;
    data['currency'] = this.currency;
    data['flight_number'] = this.flightNumber;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
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
