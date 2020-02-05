class JsonObjects {
  static var price = {
    "price": 3560,
    "seats": 37,
    "currency": "INR",
    "flight_number": "6E-ARI",
    "from": "DEL",
    "to": "CHE"
  };

  static var price_without_parameters = {
    "flight_number": "6E-ARI",
    "from": null,
    "to": null,
  };

  static var airline_without_parameters = {
    "name": null,
  };

  static var ticket = {
    "from": "DEL",
    "to": "CHE",
    "flight_number": "AC-971",
    "departure": "08:11",
    "arrival": "10:59",
    "duration": "2h 48m",
    "instructions": "",
    "stops": 1,
    "airline": {
      "id": 1103,
      "name": "Spicejet",
      "logo": "https:\/\/api.androidhive.info\/json\/images\/spicejet.png"
    }
  };

  static var ticket_list = [
    {
      "from": "DEL",
      "to": "CHE",
      "flight_number": "BY-557",
      "departure": "01:24",
      "arrival": "03:41",
      "duration": "2h 17m",
      "instructions": "Free Meals\/Snacks",
      "stops": 2,
      "airline": {
        "id": 1102,
        "name": "Air India",
        "logo": "https:\/\/api.androidhive.info\/json\/images\/airindia.png"
      }
    },
    {
      "from": "DEL",
      "to": "CHE",
      "flight_number": "CG-928",
      "departure": "18:58",
      "arrival": "21:32",
      "duration": "2h 34m",
      "instructions": "Non Refundable",
      "stops": 2,
      "airline": {
        "id": 1105,
        "name": "Jet Airways",
        "logo": "https:\/\/api.androidhive.info\/json\/images\/jetairways.png"
      }
    },
    {
      "from": "DEL",
      "to": "CHE",
      "flight_number": "UF-943",
      "departure": "17:36",
      "arrival": "20:24",
      "duration": "2h 48m",
      "instructions": "Free Meals\/Snacks",
      "stops": 1,
      "airline": {
        "id": 1102,
        "name": "Air India",
        "logo": "https:\/\/api.androidhive.info\/json\/images\/airindia.png"
      }
    },
    {
      "from": "DEL",
      "to": "CHE",
      "flight_number": "HA-749",
      "departure": "20:49",
      "arrival": "23:16",
      "duration": "2h 27m",
      "instructions": "Free Meals\/Snacks",
      "stops": 1,
      "airline": {
        "id": 1101,
        "name": "IndiGo",
        "logo": "https:\/\/api.androidhive.info\/json\/images\/indigo.png"
      }
    },
    {
      "from": "DEL",
      "to": "CHE",
      "flight_number": "SN-816",
      "departure": "09:44",
      "arrival": "12:30",
      "duration": "2h 46m",
      "instructions": "Free Meals\/Snacks",
      "stops": 1,
      "airline": {
        "id": 1103,
        "name": "Spicejet",
        "logo": "https:\/\/api.androidhive.info\/json\/images\/spicejet.png"
      }
    },
  ];
}
