import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:yathaarth/models/jsons/establishment_json.dart';
import 'package:yathaarth/models/establishment.dart';

void main() {
  test('API should fetch the token', () async {
//    final hs = HomeService();
//    HomeResponse r = await hs.getHomeData();
//    print(r);
      print(Establishment.fromJson(jsonDecode(EstablishmentJson.getJson())));
  });
}