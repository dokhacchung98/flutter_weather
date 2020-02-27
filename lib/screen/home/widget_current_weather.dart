import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import 'package:weatherapp/bloc/weather_week_bloc.dart';
import 'package:weatherapp/model/weather_current_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/screen/home/list_weather.dart';

class WidgetCurrentWeather extends StatelessWidget {
  final WeatherCurrentModel model;

  const WidgetCurrentWeather({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 14,
          ),
          SizedBox(
            height: 18,
          ),
          model == null
              ? Container(
                  color: Colors.red,
                )
              : Column(
                  children: <Widget>[
                    Text(
                      '${model.temperature.toStringAsFixed(1)}°',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 86,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${model.description}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Cảm giác thật® ${model.feelLike.toStringAsFixed(1)}°',
                      style: TextStyle(
                          color: Colors.white.withOpacity(.8), fontSize: 20),
                    ),
                  ],
                ),
          SizedBox(
            height: 32,
          ),
          model == null
              ? Container()
              : Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.tint,
                            color: Colors.white,
                          ),
                          Text(
                            '${model.humidity.toStringAsFixed(1)}%',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.temperatureLow,
                              color: Colors.white),
                          Text(
                            '${model.temperatureMax.toStringAsFixed(1)}° / ${model.temperatureMin.toStringAsFixed(1)}°',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.wind,
                            color: Colors.white,
                          ),
                          Text(
                            '${model.wind} m/s ${model.windDeg}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 48,
          ),
          BlocConsumer<WeatherWeekBloc, WeatherWeekState>(
            builder: (context, state) {
              if (state is WeatherLoadedWeek) {
                return ListWeather(
                  listModel: state.weatherWeekModel,
                );
              } else {
                return Container();
              }
            },
            listener: (context, state) {},
          )
        ],
      ),
    );
  }
}
