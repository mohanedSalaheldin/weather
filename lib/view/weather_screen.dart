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
  void initState() {
    ApiCalls.menagePermission();
    super.initState();
  }

  Future<WeatherModel?>? _myData;
  @override
  Widget build(BuildContext context) {
    _myData = ApiCalls.getData(
      myLocation: true,
    );
    return Scaffold(
      body: FutureBuilder(
        future: _myData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
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
                    suffixIcon: const Icon(
                      Icons.search,
                    ),
                    onSuffixTap: () {
                      setState(() {
                        _myData = ApiCalls.getData(
                          myLocation: false,
                          city: searchController.text,
                        );
                      });
                    },
                    onSubmitted: (p0) {},
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.location_on,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${snapshot.data?.city}',
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        '${snapshot.data?.desc}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${snapshot.data?.temp}',
                            style: const TextStyle(
                              fontSize: 38,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '°',
                            style: TextStyle(
                              fontSize: 38,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? mo = await ApiCalls.getPositionAsString();
          WeatherModel? model =
              await ApiCalls.getDataFromApiByCityName(city: mo!);
          print(model?.temp);
          print(model?.city);
        },
      ),
    );
  }
}
