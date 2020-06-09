import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:paymztest/model/video_model.dart';

class ApiProvider {
  Client client = Client();

  //This is the London weather API url available at this link: https://openweathermap.org/current
  final _baseUrl = "https://devbytes.udacity.com/devbytes.json";

  Future<List<VideoModel>> fetchVideos() async {
    final response = await client.get(
        "$_baseUrl"); // Make the network call asynchronously to fetch the London weather data.
    print(response.body.toString());

    if (response.statusCode == 200) {
      List<VideoModel> result = List();
      var jsonResponse = jsonDecode(response.body);
      var jsonArrayResponse = jsonResponse["videos"];
      for (var json in (jsonArrayResponse as List)) {
        result.add(VideoModel.fromJson(json));
      }
      return result; //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
