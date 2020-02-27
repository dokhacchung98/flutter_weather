import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/repository/city_repository.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository citiRepository;

  CityBloc({this.citiRepository}) : assert(citiRepository != null);

  @override
  CityState get initialState => CityInitial();

  @override
  Stream<CityState> mapEventToState(
    CityEvent event,
  ) async* {
    if (event is AddNewCity) {
      bool isSaved = citiRepository.addCity(event.nameCity);
      if (isSaved) {
        yield AddedCity();
      }
    } else if (event is RemoveCity) {
      bool isRemoved = citiRepository.removeCity(event.nameCity);
      print('asdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsd? $isRemoved');
      if (isRemoved) {
        yield RemovedCity();
      }
    }
  }
}
