import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_week_model.dart';
import 'package:weatherapp/util/background_util.dart';
import 'package:flare_flutter/flare_actor.dart';

class ItemWeatherWeek extends StatefulWidget {
  final WeatherWeekModel model;
  ItemWeatherWeek({Key key, this.model})
      : assert(model != null),
        super(key: key);

  @override
  _ItemWeatherWeekState createState() => _ItemWeatherWeekState();
}

class _ItemWeatherWeekState extends State<ItemWeatherWeek> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white.withOpacity(.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Text(
            '${widget.model.temperature.toStringAsFixed(2)}°',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: FlareActor(
              "assets/weather.flr",
              animation: BackgroundUtil.mapNameIcon[widget.model.icon],
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            widget.model.description,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            widget.model.time.replaceAll(' ', '\n'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(.8),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
