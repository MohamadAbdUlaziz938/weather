import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/media/temperature_convert.dart';
import 'package:weather/models/weather.dart';
import 'package:provider/provider.dart';
import 'package:weather/utils/gradiant-container-widget.dart';
import 'package:weather/viewModels/forecast_view_model.dart';
import 'package:weather/weather/views/datetime-view.dart';
import 'package:weather/weather/views/weather_description_view.dart';
import 'package:weather/weather/views/more-details-weather.dart';
import 'package:weather/weather/views/weather_summary.dart';
import '../views/last_update_view.dart';
import '../views/location_view.dart';

class UpComingDay extends StatelessWidget {
  final Weather weather;
  UpComingDay({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, model, child) => Scaffold(
        body: buildGradientContainer(model.condition, model.isDaytime,
            buildHomeView(context, weather: this.weather)),
      ),
    );
  }

  Widget buildHomeView(BuildContext context, {Weather weather}) {
    final weatherViewModel = Provider.of<ForecastViewModel>(context);
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            LocationView(
              longitude: weatherViewModel.longitude,
              latitude: weatherViewModel.latitide,
              city: weatherViewModel.city,
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: DateView(Time: this.weather.date)),
            LastUpdatedView(lastUpdatedOn: weatherViewModel.lastUpdated),
            SizedBox(height: 30),
            WeatherSummary(
                condition: weather.condition,
                temp: TemperatureConvert.kelvinToCelsius(this.weather.temp),
                feelsLike: TemperatureConvert.kelvinToCelsius(
                    this.weather.feelLikeTemp),
                isdayTime: weatherViewModel.isDaytime),
            SizedBox(height: 20),
            WeatherDescriptionView(weatherDescription: weather.description),
            Divider(thickness: 2,),
            WeatherDetails(weather: weather),
            SizedBox(height: 20),
          ],
        ));
  }
}
