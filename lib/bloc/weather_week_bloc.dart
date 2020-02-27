import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_week_model.dart';
import 'package:weatherapp/repository/city_repository.dart';
import 'package:weatherapp/repository/weather_repository.dart';

part 'weather_week_event.dart';
part 'weather_week_state.dart';

class WeatherWeekBloc extends Bloc<WeatherWeekEvent, WeatherWeekState> {
  final WeatherRepository weatherRepository;
  final CityRepository cityRepository;

  WeatherWeekBloc(
      {@required this.weatherRepository, @required this.cityRepository})
      : assert(weatherRepository != null && cityRepository != null);

  @override
  WeatherWeekState get initialState => WeatherWeekInitial();

  @override
  Stream<WeatherWeekState> mapEventToState(
    WeatherWeekEvent event,
  ) async* {
    if (event is FetchWeekWeather) {
      yield WeatherLoadingWeek();
      try {
        List<WeatherWeekModel> model =
            await weatherRepository.getWeekWeather(event.cityName);
        yield WeatherLoadedWeek(weatherWeekModel: model);
      } catch (_) {
        yield WeatherWeekError();
      }
    }
  }
}
