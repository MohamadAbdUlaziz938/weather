import 'package:flutter/material.dart';

import 'package:weather/viewModels/city_entry_viewmodel.dart';
import 'package:weather/viewModels/show-more-details.dart';
import 'config/size-config.dart';
import 'viewModels/forecast_view_model.dart';
import 'file:///C:/Users/PC/AndroidStudioProjects/weather/lib/weather/screens/home_view.dart';
import 'package:provider/provider.dart';

void main() {
//  runApp(MyApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<CityEntryViewModel>(
        create: (_) => CityEntryViewModel()),
    ChangeNotifierProvider<ForecastViewModel>(
        create: (_) => ForecastViewModel()),
    ChangeNotifierProvider<ShowMoreDetails>(
        create: (_) => ShowMoreDetails()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return
      OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return
        MaterialApp(
          title: 'Weather',
          home: HomeView(),
          debugShowCheckedModeBanner: false,
        );
      });
    });
  }
}
