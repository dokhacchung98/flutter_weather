import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/model/weather_current_model.dart';
import 'package:weatherapp/repository/city_repository.dart';
import 'package:weatherapp/repository/weather_repository.dart';

part 'weather_list_event.dart';
part 'weather_list_state.dart';

class WeatherListBloc extends Bloc<WeatherListEvent, WeatherListState> {
  final CityRepository cityRepository;
  final WeatherRepository weatherRepository;

  WeatherListBloc({this.cityRepository, this.weatherRepository})
      : assert(cityRepository != null && weatherRepository != null);

  @override
  WeatherListState get initialState => WeatherListInitial();

  @override
  Stream<WeatherListState> mapEventToState(
    WeatherListEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        List<WeatherCurrentModel> models = [];
        for (var item in cityRepository.listCityName) {
          final WeatherCurrentModel model =
              await weatherRepository.getCurrentWeather(item);
          models.add(model);
        }
        yield WeatherLoaded(models: models);
      } catch (_) {
        yield WeatherLoadError();
      }
    }
  }
}
