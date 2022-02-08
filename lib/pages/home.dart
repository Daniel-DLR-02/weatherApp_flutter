import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../model/one_call.dart';
import '../styles/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE,dd MMMM yyyy').format(now);
    String apiKey = "ffbf5ebe736d7abd05216bf7742623e7";
    String long = "-6.0025700";
    String lat = "37.3886303";
    double kelvinDegrees = -273.15;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    String id = "2510911";
    bool nightTheme = false;
    Color backgroundColor = _changeBackgroundColor(nightTheme);

    late Future<WeatherResponse> tiempoActualFuture =
        getCurrentWeatherCity(lat, long, apiKey);

    late Future<List<Hourly>> temps = fetchHourly(lat, long, apiKey);

    late Future<List<Daily>> temps_week = fetchWeekely(lat, long, apiKey);

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(1, 2), // 10% of the width, so there are ten blinds.
          colors: <Color>[
            Styles.dayBackGroundColor,
            Colors.white
          ], // red to yellow
          tileMode: TileMode.mirror, // repeats the gradient over the canvas
        ),
      ),
      //color: Styles.backGroundColor,
      child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
              child: FutureBuilder<WeatherResponse>(
            future: tiempoActualFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0, left: 20),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                snapshot.data!.name,
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        color: Styles.textColor, fontSize: 30),
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Current Location',
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        color: Styles.textColor, fontSize: 10),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 135.0),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.map_outlined,
                                    color: Styles.textColor,
                                    size: 30.0,
                                  ),
                                  tooltip: 'Abrir lista de ciudades',
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/ciudades'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.mode_night_outlined,
                                      color: Styles.textColor,
                                      size: 30.0,
                                    ),
                                    tooltip: 'Activar modo oscuro',
                                    onPressed: () =>
                                        _changeBackgroundColor(nightTheme),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: [
                          Text(
                            formattedDate,
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: Styles.textColor, fontSize: 20),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 150,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 120.0,
                                    width: 140.0,
                                    child: Row(
                                      children: [
                                        Text(
                                          (snapshot.data!.main.temp! +
                                                  kelvinDegrees)
                                              .floor()
                                              .toString(),
                                          style: GoogleFonts.ptSans(
                                              textStyle: const TextStyle(
                                                  /*color: Colors.black*/
                                                  color: Styles.textColor,
                                                  fontSize: 70)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'ºC',
                                            style: GoogleFonts.ptSans(
                                                textStyle: const TextStyle(
                                                    color: Styles.textColor,
                                                    fontSize: 50)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 17.0, top: 46),
                                    child: SizedBox(
                                      height: 120.0,
                                      width: 155.0,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .arrow_downward_outlined,
                                                      color: Styles.textColor),
                                                  Text(
                                                    (snapshot.data!.main
                                                                    .tempMin! +
                                                                kelvinDegrees)
                                                            .floor()
                                                            .toString() +
                                                        'ºC /',
                                                    style: GoogleFonts.ptSans(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Styles
                                                                    .textColor,
                                                                fontSize: 20)),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: .0),
                                                    child: Icon(
                                                        Icons
                                                            .arrow_upward_outlined,
                                                        color:
                                                            Styles.textColor),
                                                  ),
                                                  Text(
                                                    (snapshot.data!.main
                                                                    .tempMax! +
                                                                kelvinDegrees)
                                                            .floor()
                                                            .toString() +
                                                        'ºC',
                                                    style: GoogleFonts.ptSans(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Styles
                                                                    .textColor,
                                                                fontSize: 20)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Row(
                                                  children: [
                                                    Text('Feels like: ',
                                                        style: GoogleFonts.ptSans(
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Styles
                                                                        .textColor,
                                                                    fontSize:
                                                                        20))),
                                                    Text(
                                                        (snapshot.data!.main
                                                                        .feelsLike! +
                                                                    kelvinDegrees)
                                                                .floor()
                                                                .toString() +
                                                            'ºC',
                                                        style: GoogleFonts.ptSans(
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Styles
                                                                        .textColor,
                                                                    fontSize:
                                                                        20))),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Image.asset(
                              "assets/icons/" +
                                  snapshot.data!.weather[0].icon +
                                  ".png",
                              width: 175,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                snapshot.data!.weather[0].description,
                                style: GoogleFonts.ptSans(
                                    textStyle: const TextStyle(
                                        color: Styles.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, top: 30),
                            child: Row(
                              children: [
                                const Icon(Icons.wb_twighlight,
                                    color: Styles.textColor),
                                Text(
                                  DateFormat('HH:mm')
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  snapshot.data!.sys.sunrise! *
                                                      1000))
                                          .toString() +
                                      ' AM',
                                  style: GoogleFonts.ptSans(
                                      textStyle: const TextStyle(
                                          color: Styles.textColor,
                                          fontSize: 20)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 30.0),
                                  child: Icon(Icons.nights_stay,
                                      color: Styles.textColor),
                                ),
                                Text(
                                  DateFormat('HH:mm')
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  snapshot.data!.sys.sunset! *
                                                      1000))
                                          .toString() +
                                      ' PM',
                                  style: GoogleFonts.ptSans(
                                      textStyle: const TextStyle(
                                          color: Styles.textColor,
                                          fontSize: 20)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 30),
                      child: Column(
                        children: [
                          Text('Hourly forecast:',
                              style: GoogleFonts.ptSans(
                                  textStyle: const TextStyle(
                                      color: Styles.textColor, fontSize: 20))),
                          SizedBox(
                            height: 250,
                            child: FutureBuilder<List<Hourly>>(
                              future: temps,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return _weatherList(snapshot.data!);
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 5),
                      child: Column(
                        children: [
                          Text('Daily forecast:',
                              style: GoogleFonts.ptSans(
                                  textStyle: const TextStyle(
                                      color: Styles.textColor, fontSize: 20))),
                          SizedBox(
                            height: 250,
                            child: FutureBuilder<List<Daily>>(
                              future: temps_week,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return _weekList(snapshot.data!);
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ))),
    ));
  }

  Widget _weatherList(List<Hourly> listaWeather) {
    return ListView.builder(
      itemCount: 25,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return _weatherItem(listaWeather.elementAt(index), index);
      },
    );
  }

  Widget _weekList(List<Daily> listaWeather) {
    return ListView.builder(
      itemCount: listaWeather.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return _weekWeatherItem(listaWeather.elementAt(index), index);
      },
    );
  }

  Widget _weatherItem(Hourly weather, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 20.0),
      child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/icons/" + weather.weather[0].icon + ".png",
                  width: 80,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Column(
                  children: [
                    Text(
                        DateFormat('HH:mm')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                weather.dt * 1000))
                            .toString(),
                        style: GoogleFonts.ptSans(
                            textStyle: const TextStyle(
                                color: Styles.textColor, fontSize: 15))),
                    Text(
                        weather.weather[0].main +
                            " | " +
                            weather.temp.toInt().toString() +
                            "ºC",
                        style: GoogleFonts.ptSans(
                            textStyle: const TextStyle(
                                color: Styles.textColor, fontSize: 15))),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _weekWeatherItem(Daily weather, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 20.0),
      child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/icons/" + weather.weather[0].icon + ".png",
                  width: 80,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Column(
                  children: [
                    Text(
                        DateFormat('EEEE')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                weather.dt * 1000))
                            .toString(),
                        style: GoogleFonts.ptSans(
                            textStyle: const TextStyle(
                                color: Styles.textColor, fontSize: 15))),
                    Text(
                        weather.weather[0].main +
                            " | " +
                            weather.temp.eve.toInt().toString() +
                            "ºC",
                        style: GoogleFonts.ptSans(
                            textStyle: const TextStyle(
                                color: Styles.textColor, fontSize: 15))),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<List<Hourly>> fetchHourly(
      String lat, String long, String apiKey) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return OneCallModel.fromJson(jsonDecode(response.body)).hourly;
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Future<List<Daily>> fetchWeekely(
      String lat, String long, String apiKey) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return OneCallModel.fromJson(jsonDecode(response.body)).daily;
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Future<WeatherResponse> getCurrentWeatherCity(
      String lat, String long, String apiKey) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey"));

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load people');
    }
  }

  Color _changeBackgroundColor(bool nightTheme) {
    Color backgroundColor;
    if (nightTheme == false) {
      nightTheme = true;
      return backgroundColor = Styles.nightBackGroundColor;
    } else {
      nightTheme = false;
      return backgroundColor = Styles.dayBackGroundColor;
    }
  }
}
