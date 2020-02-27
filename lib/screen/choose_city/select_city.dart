import 'package:flutter/material.dart';
import 'package:weatherapp/bloc/city_bloc.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import 'package:weatherapp/bloc/weather_list_bloc.dart';
import 'package:weatherapp/repository/city_repository.dart';
import 'package:weatherapp/repository/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_city.dart';

class SelectCity extends StatefulWidget {
  final CityRepository cityRepository;
  final WeatherRepository weatherRepository;

  const SelectCity({Key key, this.cityRepository, this.weatherRepository})
      : assert(weatherRepository != null && cityRepository != null),
        super(key: key);

  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final TextEditingController _editingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CityBloc>(
          create: (context) => CityBloc(citiRepository: widget.cityRepository),
        ),
        BlocProvider<WeatherListBloc>(
          create: (context) => WeatherListBloc(
              cityRepository: widget.cityRepository,
              weatherRepository: widget.weatherRepository)
            ..add(FetchWeather()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 243, 243, 1),
        appBar: AppBar(
          title: Text(
            'Thêm thành phố',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: _editingController,
                  autofocus: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintText: 'Thành phố...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pop(context, _editingController.text.trim());
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(48, 12, 48, 12),
                  child: Text(
                    'Lựa Chọn',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              BlocBuilder<WeatherListBloc, WeatherListState>(
                  builder: (context, snapshot) {
                if (snapshot is WeatherLoading ||
                    snapshot is WeatherLoadError ||
                    snapshot is WeatherListInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot is WeatherLoaded) {
                  return Expanded(
                      child: BlocListener<CityBloc, CityState>(
                    listener: (context, state) {
                      if (state is RemovedCity) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Đã xóa thành phố',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final model = snapshot.models.elementAt(index);
                        return Dismissible(
                          key: Key(model.country),
                          onDismissed: (direction) {
                            BlocProvider.of<CityBloc>(context)
                                .add(RemoveCity(nameCity: model.country));
                          },
                          child: ItemCity(model: model),
                        );
                      },
                      itemCount: snapshot.models.length,
                    ),
                  ));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
