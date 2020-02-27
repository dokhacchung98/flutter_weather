part of 'city_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();
}

class CityInitial extends CityState {
  @override
  List<Object> get props => [];
}

class AddedCity extends CityState {
  @override
  List<Object> get props => null;
}

class RemovedCity extends CityState {
  @override
  List<Object> get props => null;
}
