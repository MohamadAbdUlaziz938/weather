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

class ShowMoreDetails with ChangeNotifier {
  bool _showMoreDetailsTempreture=false;
  bool _showMoreDetailsSunRiseSet=false;
  bool _showMoreDetailsHami_=false;

  bool get showMoreDetailsTempreture=> _showMoreDetailsTempreture;
  bool get showMoreDetailsSunRiseSet=> _showMoreDetailsSunRiseSet;
  bool get showMoreDetailsHami_=> _showMoreDetailsHami_;


  void updateshowMoreDetailsTempreture(bool showMore){
    _showMoreDetailsTempreture=showMore;
    notifyListeners();
  }
  void updateshowMoreDetailsSunRiseSet(bool showMore){
    _showMoreDetailsSunRiseSet=showMore;
    notifyListeners();
  }
  void updateshowMoreDetailsHami_(bool showMore){
    _showMoreDetailsHami_=showMore;
    notifyListeners();
  }
}
