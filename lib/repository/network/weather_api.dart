import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather_current_model.dart';
import 'package:weatherapp/model/weather_week_model.dart';

class WeatherApi {
  static const BASE_URL = 'http://api.openweathermap.org';
  final http.Client client;

  WeatherApi({@required this.client}) : assert(client != null);

  Future<WeatherCurrentModel> fetchCurrentWeather(String cityName) async {
    final locationUrl =
        '$BASE_URL/data/2.5/weather?q=$cityName&appid=a4c36ef09ca1943b8203448b5997e166&lang=vi';
    final locationResponse = await this.client.get(locationUrl);
    if (locationResponse.statusCode == 200) {
      final dataJson = jsonDecode(locationResponse.body);
      print(dataJson);
      final WeatherCurrentModel model = WeatherCurrentModel.fromJson(dataJson);
      return model;
    } else {
      return null;
    }
  }

  Future<List<WeatherWeekModel>> fetchWeekWeather(String cityName) async {
    final locationUrl =
        '$BASE_URL/data/2.5/forecast?q=${cityName}&appid=a4c36ef09ca1943b8203448b5997e166&lang=vi';
    final locationResponse = await this.client.get(locationUrl);
    if (locationResponse.statusCode == 200) {
      final parsed = jsonDecode(locationResponse.body)['list'];

      return parsed
          .map<WeatherWeekModel>((json) => WeatherWeekModel.fromJson(json))
          .toList();
    } else {
      return null;
    }
  }
}
