import 'package:flutter/material.dart';
import 'package:weatherapp/bloc/weather_bloc_delegate.dart';
import 'package:bloc/bloc.dart';
import 'package:weatherapp/screen/spashscreen/splash_screen.dart';

void main() {
  BlocSupervisor.delegate = WeatherBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(SplashScreen());
}

//5day/3hour
//http://api.openweathermap.org/data/2.5/forecast?q=ha%20noi&appid=a4c36ef09ca1943b8203448b5997e166
//current
//api.openweathermap.org/data/2.5/weather?q={city name}&appid=a4c36ef09ca1943b8203448b5997e166

//d60e58723c83d6fce82ba28aceaa9cc1
//http://api.weatherstack.com/current
// ? access_key = YOUR_ACCESS_KEY
// & query = New York
