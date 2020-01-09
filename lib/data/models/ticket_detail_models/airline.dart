class Airline {
  int id;
  String name;
  String logo;

  Airline({this.id, this.name, this.logo});

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      id: json["id"] as int,
      name: json["name"] as String,
      logo: json["logo"] as String,
    );
  }
}
