import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weatherapp/model/weather_current_model.dart';
import 'package:weatherapp/model/weather_week_model.dart';
import 'package:weatherapp/repository/city_repository.dart';
import 'package:weatherapp/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  final CityRepository cityRepository;

  WeatherBloc({@required this.weatherRepository, @required this.cityRepository})
      : assert(weatherRepository != null && cityRepository != null);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is OpenApp) {
      String nameCityFirst = cityRepository.listCity.first;
      yield WeatherOpenApp(nameCity: nameCityFirst);
    }
    if (event is FetcCurrenthWeather) {
      yield WeatherLoadingCurrent();
      try {
        final WeatherCurrentModel model =
            await weatherRepository.getCurrentWeather(event.cityName);
        yield WeatherLoadedCurrent(currentWeatherModel: model);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}
