import 'dart:ui';

class Airline {
  int id;
  String name;
  String logo;

  Airline({this.id, this.name, this.logo});

  factory Airline.fromJson(Map<String, dynamic> json) {
    if (json == null || json.length == 0) {
      return null;
    }
    return Airline(
      id: json["id"] as int,
      name: json["name"] as String,
      logo: json["logo"] as String,
    );
  }

  @override
  int get hashCode => hashValues(id, name, logo);

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType == other.runtimeType) {
      return true;
    }
    final Airline otherAirline = other;
    return id == otherAirline.id &&
        name == otherAirline.name &&
        logo == otherAirline.logo;
  }
}
