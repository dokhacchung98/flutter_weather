part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class OpenApp extends WeatherEvent {
  @override
  List<Object> get props => null;
}

class UpdateCurrentWeather extends WeatherEvent {
  final String nameCity;

  const UpdateCurrentWeather({@required this.nameCity})
      : assert(nameCity != null);

  @override
  List<Object> get props => [nameCity];
}

class FetcCurrenthWeather extends WeatherEvent {
  final String cityName;

  const FetcCurrenthWeather({@required this.cityName})
      : assert(cityName != null);

  @override
  List<Object> get props => [cityName];
}
