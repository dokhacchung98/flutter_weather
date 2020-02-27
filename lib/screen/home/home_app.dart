import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/bloc/city_bloc.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/weather_week_bloc.dart';
import 'package:weatherapp/model/weather_current_model.dart';
import 'package:weatherapp/repository/city_repository.dart';
import 'package:weatherapp/repository/weather_repository.dart';
import 'package:weatherapp/screen/choose_city/select_city.dart';
import 'package:weatherapp/screen/drawer/my_drawer.dart';
import 'package:weatherapp/screen/home/widget_current_weather.dart';
import 'package:weatherapp/screen/widgets/size_route.dart';
import 'package:weatherapp/util/background_util.dart';

class HomeApp extends StatefulWidget {
  final WeatherRepository weatherRepository;
  final CityRepository cityRepository;

  const HomeApp(
      {Key key,
      @required this.weatherRepository,
      @required this.cityRepository})
      : assert(cityRepository != null && weatherRepository != null),
        super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState(
      cityRepository: cityRepository, weatherRepository: weatherRepository);
}

class _HomeAppState extends State<HomeApp> {
  final WeatherRepository weatherRepository;
  final CityRepository cityRepository;

  _HomeAppState({this.weatherRepository, this.cityRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => WeatherBloc(
                  cityRepository: this.cityRepository,
                  weatherRepository: this.weatherRepository),
            ),
            BlocProvider(
              create: (context) => CityBloc(citiRepository: cityRepository),
            ),
            BlocProvider(
              create: (context) => WeatherWeekBloc(
                  cityRepository: cityRepository,
                  weatherRepository: weatherRepository),
            )
          ],
          child: HomeWidget(
            cityRepository: cityRepository,
            weatherRepository: weatherRepository,
          ),
        ),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  final CityRepository cityRepository;
  final WeatherRepository weatherRepository;
  HomeWidget({Key key, this.cityRepository, this.weatherRepository})
      : assert(cityRepository != null && weatherRepository != null),
        super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PageController _pageController;
  CityRepository get _cityRepository => widget.cityRepository;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)..add(OpenApp());
  }

  _HomeWidgetState() {
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(listener: (context, state) {
      if (state is WeatherError) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Lỗi lấy giữ liệu thời tiết',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      } else if (state is WeatherLoadedCurrent) {
        BlocProvider.of<WeatherWeekBloc>(context)
            .add(FetchWeekWeather(cityName: state.currentWeatherModel.country));
        BlocProvider.of<CityBloc>(context)
            .add(AddNewCity(nameCity: state.currentWeatherModel.country));
      } else if (state is WeatherOpenApp) {
        BlocProvider.of<WeatherBloc>(context)
            .add(FetcCurrenthWeather(cityName: state.nameCity));
      }
    }, child: Container(
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          WeatherCurrentModel model;
          if (state is WeatherLoadedCurrent) {
            model = state.currentWeatherModel;
          }
          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(model == null
                          ? 'assets/day_clearsky.9.png'
                          : BackgroundUtil.mapBackground[model.icon]),
                      fit: BoxFit.cover),
                ),
              ),
              Scaffold(
                drawer: Drawer(
                  child: MyDrawer(),
                ),
                backgroundColor: Colors.transparent,
                appBar: _widgetHeader(context, model),
                body: PageView(
                  children: <Widget>[
                    BlocBuilder<WeatherWeekBloc, WeatherWeekState>(
                      builder: (context, state) {
                        if (state is WeatherLoadedWeek) {
                          return WidgetCurrentWeather(
                            model: model,
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ));
  }

  Widget _widgetHeader(BuildContext context, WeatherCurrentModel model) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: Colors.white //change your color here
          ),
      title: Text(
        '${model == null ? "Đang cập nhật..." : model.country}',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 34),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            if (Scaffold.of(context).isDrawerOpen) {
              Scaffold.of(context).openEndDrawer();
            } else {
              Scaffold.of(context).openDrawer();
            }
          },
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            final cityName = await Navigator.push(
              context,
              SizeRoute(
                page: SelectCity(
                    cityRepository: widget.cityRepository,
                    weatherRepository: widget.weatherRepository),
              ),
            );
            if (cityName != null) {
              BlocProvider.of<WeatherBloc>(context)
                  .add(FetcCurrenthWeather(cityName: cityName));
            }
          },
        ),
      ],
    );
  }
}
