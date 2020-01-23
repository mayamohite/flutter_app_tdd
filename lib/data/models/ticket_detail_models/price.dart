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
}
