part of 'weather_week_bloc.dart';

abstract class WeatherWeekEvent extends Equatable {
  const WeatherWeekEvent();
}

class FetchWeekWeather extends WeatherWeekEvent {
  final String cityName;

  const FetchWeekWeather({@required this.cityName}) : assert(cityName != null);

  @override
  List<Object> get props => [cityName];
}
