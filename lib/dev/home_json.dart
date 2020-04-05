class HomeJson {
  static HomeJson _instance = new HomeJson.internal();

  HomeJson.internal();

  factory HomeJson() => _instance;

  static String getJson() {
    return '''
      [
        {
            "id": 1,
            "label": "Retailer",
            "color": "0xFF4D4D4D",
            "count": 1
        },
        {
            "id": 2,
            "label": "Distributor",
            "color": "0xFFB1D877",
            "count": 0
        },
        {
            "id": 3,
            "label": "Super Stockist",
            "color": "0xFFF16A70",
            "count": 1
        },
        {
            "id": "beat",
            "label": "BEATS",
            "color": "0xFF8CDCDA",
            "count": 0
        }
    ]
    ''';
  }
}
