import 'package:equatable/equatable.dart';

class WeatherWeekModel extends Equatable {
  String _time;
  double _temperature;
  double _temperatureMin;
  double _temperatureMax;
  String _description;
  String _icon;

  String get time => _time;
  double get temperature => _temperature;
  double get temperatureMin => _temperatureMin;
  double get temperatureMax => _temperatureMax;
  String get description => _description;
  String get icon => _icon;

  WeatherWeekModel(
      {String time,
      double temperature,
      double temperatureMin,
      double temperatureMax,
      String descrip,
      String icon}) {
    this._time = time;
    this._temperature = temperature;
    this._temperatureMin = temperatureMin;
    this._temperatureMax = temperatureMax;
    this._description = description;
    this._icon = icon;
  }

  WeatherWeekModel.fromJson(Map<String, dynamic> json) {
    _time = json['dt_txt'] != null ? json['dt_txt'] : "";
    _description = json['weather'][0]['description'] != null
        ? json['weather'][0]['description']
        : "";
    _icon =
        json['weather'][0]['icon'] != null ? json['weather'][0]['icon'] : "";
    _temperature = json['main']['temp'] != null
        ? json['main']['temp'].toDouble() - 273.15
        : 0;
    _temperatureMin = json['main']['temp_min'] != null
        ? json['main']['temp_min'].toDouble() - 273.15
        : 0;
    _temperatureMax = json['main']['temp_max'] != null
        ? json['main']['temp_max'].toDouble() - 273.15
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }

  @override
  List<Object> get props => [
        _time,
        _temperature,
        _temperatureMax,
        _temperatureMin,
        _description,
        _icon
      ];
}
