import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/api/open_weather_map_weather_api.dart';
import 'package:weather/media/temperature_convert.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/services/forecast_service.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;
  bool _showMoreDetails = false;

  WeatherCondition _condition;
  String _description;
  double _minTemp;
  double _maxTemp;
  double _temp;
  double _feelsLike;
  int _locationId;
  String _lastUpdated;

  String _city;
  double _latitude;
  double _longitude;
  List<Weather> _daily;
  bool _isDayTime;

  WeatherCondition get condition => _condition;
  String get description => _description;
  double get minTemp => _minTemp;
  double get maxTemp => _maxTemp;
  double get temp => _temp;
  double get feelsLike => _feelsLike;
  int get locationId => _locationId;
  String get lastUpdated => _lastUpdated;
  String get city => this._city;
  double get longitude => _longitude;
  double get latitide => _latitude;
  bool get isDaytime => _isDayTime;
  bool get showMoreDetails {
    return _showMoreDetails;
  }

  List<Weather> get daily => _daily;
  ForecastService forecastService;
  ForecastViewModel() {
    forecastService = ForecastService(OpenWeatherMapWeatherApi());
  }
  Future<Forecast> getLatestWeather(String city, {BuildContext context}) async {
    setRequestPendingState(true);
    this.isRequestError = false;
    Forecast latest;
    try {
      //  await Future.delayed(Duration(seconds: 1), () => {});
      latest = await forecastService.getWeather(city);
      // .catchError((onError) => this.isRequestError = true);
      latest.city = city;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //chached city and last update in memory to upload theme later
      await prefs.setString('city', city);
      latest.lastUpdated =
          "${DateFormat('MMMd').format(DateTime.now()).toString()} at ${DateFormat('jm').format(DateTime.now()).toString()}";
      await prefs.setString('Time', latest.lastUpdated);
    } catch (e) {
      latest = await forecastService.getWeatherFromcash(city: "forecast");
      latest.city = await forecastService.getCityFromCached();
      latest.lastUpdated = await forecastService.getLastUpdatedFromCached();
      if (latest == null)
        this.isRequestError = true;
      this.isRequestError = false;
    }
    this.isWeatherLoaded = true;
    updateModel(latest);
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  void setRequestPendingState(bool isPending) {
    this.isRequestPending = isPending;
    notifyListeners();
  }

  Future<void> refreshWeather(String city) async {
    return getLatestWeather(city);
  }

  void updateModel(Forecast forecast) {
    if (isRequestError) return;
    _condition = forecast.current.condition;
    //_city = Strings.toTitleCase(forecast.city);
    _city = forecast.city;
    _description = forecast.current.description;
    _lastUpdated = forecast.lastUpdated;
    _temp = TemperatureConvert.kelvinToCelsius(forecast.current.temp);
    _feelsLike =
        TemperatureConvert.kelvinToCelsius(forecast.current.feelLikeTemp);
    _longitude = forecast.longitude;
    _latitude = forecast.latitude;
    _daily = forecast.daily;
    _isDayTime = forecast.isDayTime;
  }

  void updateMoreDetails(bool showMore) {
    _showMoreDetails = showMore;
    notifyListeners();
  }

}
