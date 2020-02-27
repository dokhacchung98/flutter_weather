part of 'weather_list_bloc.dart';

abstract class WeatherListState extends Equatable {
  const WeatherListState();
}

class WeatherListInitial extends WeatherListState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherListState {
  @override
  List<Object> get props => null;
}

class WeatherLoaded extends WeatherListState {
  final List<WeatherCurrentModel> models;

  WeatherLoaded({this.models}) : assert(models != null);
  @override
  List<Object> get props => [models];
}

class WeatherLoadError extends WeatherListState {
  @override
  List<Object> get props => null;
}
