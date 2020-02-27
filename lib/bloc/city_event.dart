part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
}

class AddNewCity extends CityEvent {
  final String nameCity;

  AddNewCity({this.nameCity}) : assert(nameCity != null);

  @override
  List<Object> get props => null;
}

class RemoveCity extends CityEvent {
  final String nameCity;

  RemoveCity({this.nameCity}) : assert(nameCity != null);

  @override
  List<Object> get props => null;
}
