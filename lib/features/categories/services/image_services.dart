import 'dart:convert';

import "package:http/http.dart" as http;

import '../../../core/constants/keys.dart';

class ImageServices {
  Future<List<String>> getRandomImages() async {
    List<String> imageUrl = [];
    try {
      final http.Response res = await http
          .get(Uri.parse("$unsplashUrl/photos/?client_id=$unsplashAccessKey"));

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        imageUrl = data.map((e) {
          String d = e["urls"]["regular"];
          return d;
        }).toList();
        return imageUrl;
      }

      return Future.error(res.statusCode);
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
}
