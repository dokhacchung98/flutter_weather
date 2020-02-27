import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherapp/repository/city_repository.dart';
import 'package:weatherapp/repository/network/weather_api.dart';
import 'package:weatherapp/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/screen/home/home_app.dart';
import 'package:weatherapp/screen/widgets/fade_in.dart';
import 'package:weatherapp/screen/widgets/fade_out.dart';

class SplashScreen extends StatefulWidget {
  final WeatherRepository weatherRepository =
      WeatherRepository(weatherApi: WeatherApi(client: http.Client()));
  final CityRepository cityRepository = CityRepository();

  SplashScreen({Key key}) : super(key: key);
  Timer timer;
  int timeDown = 3;
  bool isTimeOut = false;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PermissionStatus statusPermission;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage)
        .then(_updateStatus);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    widget.timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (widget.timeDown <= 1) {
            widget.timeDown = 0;
            timer.cancel();
            if (widget.isTimeOut != true) {
              widget.isTimeOut = true;
            }
          } else {
            widget.timeDown = widget.timeDown - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTimeOut) {
      if (statusPermission == PermissionStatus.granted) {
        return HomeApp(
            cityRepository: widget.cityRepository,
            weatherRepository: widget.weatherRepository);
      } else {
        _askPermission();
      }
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/splash_screen.png'),
                fit: BoxFit.fitHeight),
          ),
          child: Directionality(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 86,
                ),
                FadeIn(
                  3,
                  Image(
                    width: 100,
                    height: 100,
                    image: AssetImage('assets/ic_launcher.png'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                FadeOut(
                  3,
                  Text(
                    'Weather App',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                CircularProgressIndicator(),
              ],
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }

  _askPermission() {
    PermissionHandler()
        .requestPermissions([PermissionGroup.storage]).then(_onStatusRequested);
  }

  _onStatusRequested(Map<PermissionGroup, PermissionStatus> value) {
    _updateStatus(value[PermissionGroup.storage]);
  }

  _updateStatus(PermissionStatus status) {
    if (status != statusPermission) {
      setState(() {
        statusPermission = status;
      });
    }
  }
}
