import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/api_key.dart';
import 'package:http/http.dart' as http;

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
                rtl: true,
                width: MediaQuery.sizeOf(context).width / .9,
                textController: searchController,
                onSuffixTap: () {
                  setState(() {
                    searchController.clear();
                  });
                },
                onSubmitted: (p0) {},
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
                      Icon(Icons.location_on_outlined),
                      Text('data'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
              {'q': 'cairo', "units": "metric", "appid": apiKey});
          final http.Response response = await http.get(url);
          print(response.body);
        },
      ),
    );
  }
}
