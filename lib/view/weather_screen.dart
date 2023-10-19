import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/logic/models/weather_model.dart';
import 'package:weather_app/logic/services/api_calls.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

TextEditingController searchController = TextEditingController();

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 65, 89, 224),
              Color.fromARGB(255, 83, 92, 215),
              Color.fromARGB(255, 86, 88, 177),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimSearchBar(
                color: const Color(0xfff39060),
                rtl: true,
                width: MediaQuery.sizeOf(context).width / .9,
                textController: searchController,
                onSuffixTap: () {
                  // setState(() {
                  //   searchController.clear();
                  // });
                },
                onSubmitted: (p0) async {
                  ApiCalls call = ApiCalls();
                  WeatherModel? mo = await call.getDataFromApiByCityName(
                      city: searchController.text);

                  print(mo?.toJson());
                },
              ),
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        'Dubai',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Weather message',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '35',
                        style: TextStyle(
                          fontSize: 38,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '°',
                        style: TextStyle(
                          fontSize: 38,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'C',
                        style: TextStyle(
                          fontSize: 38,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
      //         {'q': 'cairo', "units": "metric", "appid": apiKey});
      //     final http.Response response = await http.get(url);
      //     print(response.body);
      //   },
      // ),
    );
  }
}
