import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:weather/viewModels/forecast_view_model.dart';

class CityEntryViewModel with ChangeNotifier {
  String _city="dubai";
  CityEntryViewModel(){}
  String get city => _city;
  void refreshWeather(String newCity, BuildContext context) {
    Provider.of<ForecastViewModel>(context, listen: false)
        .getLatestWeather(newCity, context: context);
    notifyListeners();
  }
  void updateCity(String newCity) {
    _city = newCity;
  }
}