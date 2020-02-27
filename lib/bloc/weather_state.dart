part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => null;
}

class WeatherOpenApp extends WeatherState {
  final String nameCity;
  const WeatherOpenApp({this.nameCity}) : assert(nameCity != null);
  @override
  List<Object> get props => [nameCity];
}

class WeatherLoadingCurrent extends WeatherState {
  @override
  List<Object> get props => null;
}

class WeatherLoadedCurrent extends WeatherState {
  final WeatherCurrentModel currentWeatherModel;

  WeatherLoadedCurrent({@required this.currentWeatherModel})
      : assert(currentWeatherModel != null);

  @override
  List<Object> get props => [currentWeatherModel];
}

class WeatherError extends WeatherState {
  @override
  List<Object> get props => null;
}
