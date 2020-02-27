import 'package:equatable/equatable.dart';
import 'package:weatherapp/util/convert_wind_direction.dart';

class WeatherCurrentModel extends Equatable {
  String _description;
  String _icon;
  String _country;
  double _wind;
  String _winDeg;
  double _humidity;
  double _temperature;
  double _feelLike;
  double _temperatureMin;
  double _temperatureMax;

  String get description => _description;
  String get icon => _icon;
  String get country => _country;
  double get wind => _wind;
  String get windDeg => _winDeg;
  double get humidity => _humidity;
  double get temperature => _temperature;
  double get temperatureMin => _temperatureMin;
  double get temperatureMax => _temperatureMax;
  double get feelLike => _feelLike;

  set description(value) => _description = value;
  set icon(value) => _icon = value;
  set country(value) => _country = value;
  set wind(value) => _wind = value;
  set windDeg(value) => _winDeg = _winDeg;
  set humidity(value) => _humidity = value;
  set temperature(value) => _temperature = value;
  set temperatureMin(value) => _temperatureMin = value;
  set temperatureMax(value) => _temperatureMax = value;
  set feelLike(value) => _feelLike = value;

  WeatherCurrentModel(
      {String description,
      String icon,
      String country,
      double wind,
      String windDeg,
      double humidity,
      double temperature,
      double temperatureMin,
      double temperatureMax,
      double feelLike}) {
    this._description = description;
    this._icon = icon;
    this._country = country;
    this._wind = wind;
    this._winDeg = windDeg;
    this._humidity = humidity;
    this._temperature = temperature;
    this._temperatureMin = temperatureMin;
    this._temperatureMax = temperatureMax;
    this._feelLike = feelLike;
  }

  @override
  List<Object> get props => [
        _description,
        _icon,
        _country,
        _wind,
        _winDeg,
        _humidity,
        _temperature,
        _feelLike,
        _temperatureMin,
        _temperatureMax
      ];

  WeatherCurrentModel.fromJson(Map<String, dynamic> json) {
    _description = json['weather'][0]['description'] != null
        ? json['weather'][0]['description']
        : "";
    _icon =
        json['weather'][0]['icon'] != null ? json['weather'][0]['icon'] : "";
    _country = json['name'] != null ? json['name'] : '';
    _wind =
        json['wind']['speed'] != null ? json['wind']['speed'].toDouble() : 0;
    double tmp =
        json['wind']['deg'] != null ? json['wind']['deg'].toDouble() : 0.0;
    _winDeg = ConvertWindDirection.Convert(direction: tmp);
    _humidity = json['main']['humidity'] != null
        ? json['main']['humidity'].toDouble()
        : 0;
    _temperature = json['main']['temp'] != null
        ? json['main']['temp'].toDouble() - 273.15
        : 0;
    _temperatureMin = json['main']['temp_min'] != null
        ? json['main']['temp_min'].toDouble() - 273.15
        : 0;
    _temperatureMax = json['main']['temp_max'] != null
        ? json['main']['temp_max'].toDouble() - 273.15
        : 0;
    _feelLike = json['main']['feels_like'] != null
        ? json['main']['feels_like'].toDouble() - 273.15
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
