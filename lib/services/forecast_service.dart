import 'package:weather/api/weather_api.dart';
import 'package:weather/models/forecast.dart';

class ForecastService {
  final WeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeather(String city) async {
    final location = await weatherApi.getLocation(city);
    return await weatherApi.getWeather(location);
  }
  Future<Forecast> getWeatherFromcash({String city}) async {
    return await weatherApi.getForcastChached(city: city);
  }
  Future<String> getCityFromCached() async {
    return await weatherApi.getCityChached();
  }
  Future<String> getLastUpdatedFromCached() async {
    return await weatherApi.getLastUpdatedCached();
  }
}