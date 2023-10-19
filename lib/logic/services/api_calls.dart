import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';
import 'package:weather_app/logic/models/weather_model.dart';

class ApiCalls {
  
  Future<WeatherModel?> getDataFromApiByCityName({
    required String city,
  }) async {
    WeatherModel? model;

    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'q': city, "units": "metric", "appid": apiKey});
    final http.Response response = await http.get(url);
    Map<String, dynamic> json = jsonDecode(response.body);
    model = WeatherModel.fromJson(json);
    return model;
  }

  Future<String?> getCurrentLocation() async {
    bool locationEnabled;
    LocationPermission permission;
    locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      Fluttertoast.showToast(
          msg: "Location is Disabled",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.always) {
          getPosition();
        }
      }
    }
    return null;
  }

  Future<Position> getPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<String?> fromPosToString() async {
    Position position = await getPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks[0].locality;
  }
}
