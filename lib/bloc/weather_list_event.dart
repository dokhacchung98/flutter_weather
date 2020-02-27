part of 'weather_list_bloc.dart';

abstract class WeatherListEvent extends Equatable {
  const WeatherListEvent();
}

class FetchWeather extends WeatherListEvent {
  @override
  List<Object> get props => null;
}
