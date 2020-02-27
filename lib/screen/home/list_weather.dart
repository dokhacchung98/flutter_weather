import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weatherapp/model/weather_week_model.dart';

import 'item_weather_week.dart';

class ListWeather extends StatelessWidget {
  final List<WeatherWeekModel> listModel;
  const ListWeather({Key key, this.listModel})
      : assert(listModel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ItemWeatherWeek(model: listModel[index]);
        },
        itemCount: listModel.length,
      ),
    );
  }
}
