import 'package:flutter/foundation.dart';
import 'package:weatherapp/model/weather_current_model.dart';
import 'package:weatherapp/model/weather_week_model.dart';
import 'package:weatherapp/repository/network/weather_api.dart';

class WeatherRepository {
  final WeatherApi weatherApi;

  WeatherRepository({@required this.weatherApi}) : assert(weatherApi != null);

  Future<WeatherCurrentModel> getCurrentWeather(String cityName) async {
    return await weatherApi.fetchCurrentWeather(cityName);
  }

  Future<List<WeatherWeekModel>> getWeekWeather(String cityName) async {
    return await weatherApi.fetchWeekWeather(cityName);
  }
}
