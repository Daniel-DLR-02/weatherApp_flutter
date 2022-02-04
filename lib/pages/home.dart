import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE,dd MMMM yyyy').format(now);
    String city = "Sevilla";
    String apiKey = "ffbf5ebe736d7abd05216bf7742623e7";
    String long = "-6.0025700";
    String lat = "37.3886303";
    String weather = "Light Drizzle";
    String temp = "22";
    double kelvinDegrees = -273.15;

    late Future<WeatherResponse> tiempoActualFuture =
        getCurrentWeatherCity(lat, long, apiKey);

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
                child: FutureBuilder<WeatherResponse>(
              future: tiempoActualFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0, left: 30),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  snapshot.data!.name,
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 30),
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Current Location',
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: Color(0xFF616161),
                                          fontSize: 10),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 170.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.map_outlined,
                                    color: Color(0xFF616161),
                                    size: 30.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Icon(
                                      Icons.settings_outlined,
                                      color: Color(0xFF616161),
                                      size: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Column(
                          children: [
                            Text(
                              formattedDate,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF616161), fontSize: 20),
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 100.0, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    (snapshot.data!.main.temp + kelvinDegrees)
                                        .roundToDouble()
                                        .toString(),
                                    style: GoogleFonts.ptSans(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 100)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 35.0),
                                    child: Text(
                                      'ºC',
                                      style: GoogleFonts.ptSans(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 50)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 125.0, top: 10),
                              child: Row(
                                children: [
                                  const Icon(Icons.arrow_downward_outlined,
                                      color: Color(0xFF616161)),
                                  Text(
                                    (snapshot.data!.main.tempMin +
                                                kelvinDegrees)
                                            .roundToDouble()
                                            .toString() +
                                        'ºC',
                                    style: GoogleFonts.ptSans(
                                        textStyle: const TextStyle(
                                            color: Color(0xFF616161),
                                            fontSize: 20)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Icon(Icons.arrow_upward_outlined,
                                        color: Color(0xFF616161)),
                                  ),
                                  Text(
                                    (snapshot.data!.main.tempMax +
                                                kelvinDegrees)
                                            .roundToDouble()
                                            .toString() +
                                        'ºC',
                                    style: GoogleFonts.ptSans(
                                        textStyle: const TextStyle(
                                            color: Color(0xFF616161),
                                            fontSize: 20)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Image.network(
                                /*"https://icon-library.com/images/rain-icon-png/rain-icon-png-25.jpg"*/
                                "http://openweathermap.org/img/w/" +
                                    snapshot.data!.weather[0].icon +
                                    ".png",
                                width: 200,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  snapshot.data!.weather[0].description,
                                  style: GoogleFonts.ptSans(
                                      textStyle: const TextStyle(
                                          color: Color(0xFF616161),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 90, top: 40),
                              child: Row(
                                children: [
                                  const Icon(Icons.wb_twighlight,
                                      color: Color(0xFF616161)),
                                  Text(
                                    DateFormat('HH:MM')
                                            .format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    snapshot.data!.sys.sunrise *
                                                        1000))
                                            .toString() +
                                        ' AM',
                                    style: GoogleFonts.ptSans(
                                        textStyle: const TextStyle(
                                            color: Color(0xFF616161),
                                            fontSize: 20)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: Icon(Icons.nights_stay,
                                        color: Color(0xFF616161)),
                                  ),
                                  Text(
                                    DateFormat('HH:MM')
                                            .format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    snapshot.data!.sys.sunset *
                                                        1000))
                                            .toString() +
                                        ' PM',
                                    style: GoogleFonts.ptSans(
                                        textStyle: const TextStyle(
                                            color: Color(0xFF616161),
                                            fontSize: 20)),
                                  ),
                                ],
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
            ))));
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
}
