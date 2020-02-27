import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_current_model.dart';
import 'package:weatherapp/util/background_util.dart';

class ItemCity extends StatefulWidget {
  final WeatherCurrentModel model;
  ItemCity({Key key, this.model})
      : assert(model != null),
        super(key: key);

  @override
  _ItemCityState createState() => _ItemCityState();
}

class _ItemCityState extends State<ItemCity> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, widget.model.country);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: AssetImage(widget.model == null
                  ? 'assets/day_clearsky_2x4.png'
                  : BackgroundUtil.mapBackgroundChild[widget.model.icon]),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.model == null
                    ? '--'
                    : '${widget.model.temperature.toStringAsFixed(1)}°',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                widget.model == null ? '--' : '${widget.model.country}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
