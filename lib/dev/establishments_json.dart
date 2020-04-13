class EstablishmentsJson {
  static EstablishmentsJson _instance = EstablishmentsJson.internal();

  EstablishmentsJson.internal();

  factory EstablishmentsJson() => _instance;

  static String getJson() {
    return '''
      [
        {
            "id": 2,
            "name": "Establishment Retailer",
            "contact_name": "Test Name 2",
            "mobile": "+917042401007",
            "gst": null,
            "pan": null,
            "remarks": null,
            "registration_date": "2020-03-10T16:51:58.000000Z",
            "type": {
                "id": 1,
                "name": "Retailer"
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
            }
        },
        {
            "id": 1,
            "name": "Establishment SS",
            "contact_name": "Test Name 1",
            "mobile": "+917042401008",
            "gst": null,
            "pan": null,
            "remarks": null,
            "registration_date": "2020-03-09T11:50:27.000000Z",
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
            }
        }
    ]
    ''';
  }
}
