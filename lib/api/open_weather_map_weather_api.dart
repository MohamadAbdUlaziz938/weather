import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/api/weather_api.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/models/location.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenWeatherMapWeatherApi extends WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const apiKey = "c20f4a879569c5d1ebc16fe88c519d29";
  static LocalStorage _localStorage=new LocalStorage("forecast");
  http.Client httpClient;

  OpenWeatherMapWeatherApi() {
    this.httpClient = new http.Client();
  }

  Future<Location> getLocation(String city) async {
    final requestUrl = '$endPointUrl/weather?q=$city&APPID=$apiKey';
    final response = await this.httpClient.get(Uri.parse(requestUrl));
    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }

    return Location.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Forecast> getWeather(Location location,{String city}) async {

    final requestUrl =
        '$endPointUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&APPID=$apiKey';
    final response = await this.httpClient.get(Uri.parse(requestUrl));
    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    saveForecast_(jsonDecode(response.body));


    return Forecast.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Forecast> getForcastChached({String city}) async{
    var forcast =await getFromCached(city: city);
    return forcast;

  }

  @override
  Future<Forecast> getFromCached({String city}) async{
    await _localStorage.ready;
    print("getFromCached");
    print(city);
    Map<String,dynamic>data=_localStorage.getItem(city);
   // Forecast forecast=_localStorage.getItem(city);
    print("getFromCached");
    print(city);
    //print(forecast);
    if(data==null){
      return null;
    }
   // print(forecast);
    Forecast forecast=Forecast.fromJson(data);
    return forecast;
  }

  @override
  Future<Forecast> saveForecast({Forecast forecast,String city}) async{
    await _localStorage.ready;
    _localStorage.setItem(city, forecast);

  }

  Future<Forecast> saveForecast_(Map <String,dynamic> m) async{
    await _localStorage.ready;
    _localStorage.setItem("forecast", m);

  }

  @override
  Future<String> getCityChached() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('city'));
  }

  @override
  Future<String> getLastUpdatedCached() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('Time') ?? "Unknown");
  }

}