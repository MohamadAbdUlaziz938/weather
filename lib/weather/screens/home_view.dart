import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/media/strings.dart';
import 'package:weather/models/weather.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/forecast_service.dart';
import 'package:weather/utils/container.dart';
import 'package:weather/utils/gradiant-container-widget.dart';
import 'package:weather/viewModels/city_entry_viewmodel.dart';
import 'package:weather/viewModels/forecast_view_model.dart';
import 'package:weather/weather/dialogs/loading-dialog.dart';
import 'package:weather/weather/views/datetime-view.dart';
import 'package:weather/weather/views/weather_description_view.dart';
import 'package:weather/weather/views/weather_summary.dart';
import '../views/city_entry_view.dart';
import '../views/daily_summary_view.dart';
import '../views/last_update_view.dart';
import '../views/location_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    onStart();
  }

  Future<void> onStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final weatherViewModel = Provider.of<ForecastViewModel>(context, listen: false);
    //here we get city we searched ,if null we use default value "dubai"
    //or we can spicify mobile location and use it
    String city=prefs.getString("city")??Provider.of<CityEntryViewModel>(context, listen: false).city;
    await weatherViewModel.refreshWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, model, child) => Scaffold(
        body: buildGradientContainer(
            model.condition, model.isDaytime, buildHomeView(context)),
      ),
    );
  }

  Widget buildHomeView(BuildContext context) {
    DateTime dataNow = DateTime.now();
    return Consumer<ForecastViewModel>(
        builder: (context, weatherViewModel, child) =>
     Container(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
            color: Colors.transparent,
            backgroundColor: Colors.transparent,
            onRefresh: () =>
                weatherViewModel.refreshWeather(weatherViewModel.city),
            //onRefresh: () => Future.sync(weatherViewModel.refreshWeather),
            child: ListView(
              children: <Widget>[
                CityEntryView(),
                weatherViewModel.isRequestPending
                    ? buildBusyIndicator()
                    : weatherViewModel.isRequestError
                        ? Center(
                            child: Text(Strings.backEndError,
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white)))
                        : Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          child: Text(
                                            DateFormat('jm')
                                                .format(DateTime.now())
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        DateView(
                                          Time: dataNow,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    LocationView(
                                      longitude: weatherViewModel.longitude,
                                      latitude: weatherViewModel.latitide,
                                      city: weatherViewModel.city??"",
                                      //city: "dubai",
                                    ),
                                  ],
                                ),
                                LastUpdatedView(
                                    lastUpdatedOn:
                                        weatherViewModel.lastUpdated??""),
                                SizedBox(height: 30),
                                WeatherSummary(
                                    condition: weatherViewModel.condition,
                                    temp: weatherViewModel.temp,
                                    feelsLike: weatherViewModel.feelsLike,
                                    isdayTime: weatherViewModel.isDaytime),
                                SizedBox(height: 20),
                                WeatherDescriptionView(
                                    weatherDescription:
                                        weatherViewModel.description??""),
                                SizedBox(height: 10),
                                Divider(),
                                SizedBox(height: 20),
                              buildDailySummary(weatherViewModel.daily),
                              SizedBox(height: 20),
                              ]),
              ],
            ))));
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return dailyForecast!=null? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dailyForecast
            .map((item) => new DailySummaryView(
                  weather: item,
                ))
            .toList()):Container();

  }

  // Future<void> refreshWeather(ForecastViewModel weatherVM, BuildContext context) async{
  //   print("refreshWeather");
  //   // get the current city
  //   String city = Provider.of<CityEntryViewModel>(context, listen: false).city;
  //   return weatherVM.getLatestWeather(city);
  // }

}
