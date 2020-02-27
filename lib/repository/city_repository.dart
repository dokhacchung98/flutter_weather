import 'package:shared_preferences/shared_preferences.dart';

class CityRepository {
  static final String SAVE_DATA_CITY = 'SAVE_DATA_CITY';
  SharedPreferences sharedPreferences;
  Set<String> _listCity = Set();

  Set<String> get listCity => _listCity;

  set listCity(Set<String> value) => _listCity = value;

  CityRepository() {
    createSharedPreferences();
    String data;
    if (data == null) {
      data = 'hà nội|';
    }
    for (var item in data.split('|')) {
      if (item != null && item.isNotEmpty) {
        _listCity.add(item);
      }
    }
  }

  createSharedPreferences() async {
    this.sharedPreferences = await SharedPreferences.getInstance();
  }

  bool removeCity(String cityName) {
    if (_listCity.length > 1) {
      var tmp = _listCity.remove(cityName.toLowerCase());
      if (tmp) {
        saveData();
      }
      return tmp;
    }
    return false;
  }

  bool addCity(String cityName) {
    var tmp = _listCity.add(cityName.toLowerCase());
    if (tmp) {
      saveData();
    }
    return tmp;
  }

  List<String> get listCityName => _listCity.toList();

  Future saveData() async {
    String data = '';
    for (var item in listCityName) {
      data += '$item|';
    }
    await this.sharedPreferences.setString(SAVE_DATA_CITY, data);
  }
}
