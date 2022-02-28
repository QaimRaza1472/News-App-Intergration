import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_api_integration/Constants/strings.dart';
import 'package:rest_api_integration/Model/newsInfo.dart';

class Api_Manager {

     Future <NewsModel> getNews() async {
          var client = http.Client();
          var newsModel = null;

          try {
               var response = await client.get(Strings.news_url);
               if (response.statusCode == 200) {
                    var jsonString = response.body;
                    var jsonMap = json.decode(jsonString);
                    newsModel = NewsModel.fromJson(jsonMap);
               }
          }
          catch (Exception) {
               return newsModel;
          }
          return newsModel;

     }
}



