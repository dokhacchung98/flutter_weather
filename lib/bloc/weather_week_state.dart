part of 'weather_week_bloc.dart';

abstract class WeatherWeekState extends Equatable {
  const WeatherWeekState();
}

class WeatherWeekInitial extends WeatherWeekState {
  @override
  List<Object> get props => [];
}

class WeatherLoadingWeek extends WeatherWeekState {
  @override
  List<Object> get props => null;
}

class WeatherLoadedWeek extends WeatherWeekState {
  final List<WeatherWeekModel> weatherWeekModel;

  WeatherLoadedWeek({@required this.weatherWeekModel})
      : assert(weatherWeekModel != null);

  @override
  List<Object> get props => [weatherWeekModel];
}

class WeatherWeekError extends WeatherWeekState {
  @override
  List<Object> get props => null;
}
