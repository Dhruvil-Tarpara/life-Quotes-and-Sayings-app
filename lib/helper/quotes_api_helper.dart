import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:quotes/globals/globals.dart';
import 'package:quotes/models/model.dart';

class QuotesAPI {
  QuotesAPI._();

  static final QuotesAPI quotesAPI = QuotesAPI._();

  Future<List<Quotes>?> getData({required String tableName}) async {
    http.Response res = await http.get(
      Uri.parse((Global.isAuthor)
          ? "https://api.quotable.io/quotes/?author=$tableName"
          : "https://api.quotable.io/quotes/?tags=${(tableName == "Latest") ? "famous-quotes" : tableName}"),
    );

    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);
      List results = data["results"];
      List<Uint8List> images = [];
      for (int i = 0; i < data.length; i++) {
        http.Response image = await http.get(
          Uri.parse(
              "https://source.unsplash.com/random/${i + 1}?background,${(tableName == "Latest" || Global.isAuthor) ? "nature" : tableName} ,dark"),
        );
        if (image.statusCode == 200) {
          images.add(image.bodyBytes);
        }
      }
      List<Quotes> quotesList = results
          .map((e) =>
              Quotes.fromData(data: e, image: images[results.indexOf(e)]))
          .toList();

      return quotesList;
    }
    return null;
  }
}
