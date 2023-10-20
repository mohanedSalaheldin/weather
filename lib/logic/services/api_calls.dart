import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';
import 'package:weather_app/logic/models/weather_model.dart';

class ApiCalls {
  static Future<WeatherModel?> getDataFromApiByCityName({
    required String city,
    // required bool byLocation,
  }) async {
    WeatherModel? model;
    // if (byLocation) {
    //   city = getPositionAsString();
    // }
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'q': city, "units": "metric", "appid": apiKey});
    final http.Response response = await http.get(url);
    Map<String, dynamic> json = jsonDecode(response.body);
    model = WeatherModel.fromJson(json);
    return model;
  }

  static Future<WeatherModel?> getCurrentLocation() async {
    WeatherModel? model;
    String? city = await getPositionAsString();
    print(city);
    model = await getDataFromApiByCityName(city: city!);
    return model;
  }

  static void menagePermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Permission denied';
      }
    }
  }

  static Future<String?> getPositionAsString() async {
    return await Geolocator.getCurrentPosition().then(
      (value) async {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(value.latitude, value.longitude);
        print(placemarks[0].toString());
        return placemarks[0].locality;
      },
    );
  }
}
