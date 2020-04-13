class HomeJson {
  static HomeJson _instance = HomeJson.internal();

  HomeJson.internal();

  factory HomeJson() => _instance;

  static String getJson() {
    return '''
      {
        "stats": {
            "beats": 0,
            "customers": 2,
            "orders": 0
        },
        "user": {
            "name": "Labeen Surana",
            "mobile": "7042401008",
            "email": "anshu.mahabir@example.org"
        }
      }
    ''';
  }
}
