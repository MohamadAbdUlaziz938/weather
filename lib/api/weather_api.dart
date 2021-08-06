import 'package:weather/models/location.dart';
import 'package:weather/models/forecast.dart';

abstract class WeatherApi {
  Future<Forecast> getWeather(Location location);
  Future<Forecast> getForcastChached({String city});
  Future<Forecast> getFromCached({String city});
  Future<Forecast> saveForecast({Forecast forecast,String city});
  Future<Location> getLocation(String city);
  Future<String> getCityChached();
  Future<String> getLastUpdatedCached();

}