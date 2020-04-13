class EstablishmentJson {
  static EstablishmentJson _instance = EstablishmentJson.internal();

  EstablishmentJson.internal();

  factory EstablishmentJson() => _instance;

  static String getJson() {
    return '''
      {
        "id": 1,
        "name": "Establishment SS",
        "contact_name": "Test Name 1",
        "mobile": "+917042401008",
        "gst": null,
        "pan": null,
        "remarks": null,
        "registration_date": "2020-03-09T11:50:27.000000Z",
        "parent_establishment_id": null,
        "type": {
            "id": 3,
            "name": "Super Stockist"
        },
        "status": {
            "id": 2,
            "name": "REGISTERED"
        },
        "assignee": {
            "id": 1,
            "name": "Labeen Surana",
            "mobile": "7042401008",
            "email": "anshu.mahabir@example.org"
        },
        "address": {
            "id": 1,
            "addressable_type": "App\Establishment",
            "addressable_id": 1,
            "address_line_1": "628, 2nd Floor",
            "address_line_2": null,
            "landmark": null,
            "city": "Gurugram",
            "pincode": "122001",
            "lat": "64.22",
            "long": "183.11",
            "state_id": 13,
            "district_id": 157,
            "state": {
                "id": 13,
                "name": "HARYANA"
            },
            "district": {
                "id": 157,
                "name": "Gurgaon"
            }
        }
    }
    ''';
  }
}
