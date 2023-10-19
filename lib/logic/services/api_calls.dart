import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';
import 'package:weather_app/logic/models/weather_model.dart';

class ApiCalls {
  static WeatherModel getDataFromApiBySearch({required city}) {
    WeatherModel model=WeatherModel();
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'q': city, "units": "metric", "appid": apiKey});
    http.get(url).then((value) {
      model = WeatherModel.fromJson(jsonDecode(value.body));
    });
    return model;
    // print(response.body);
  }

  // Future<WeatherModel> getDataFromApiByLocation() async {
  //   var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
  //       {'q': 'cairo', "units": "metric", "appid": apiKey});
  //   final http.Response response = await http.get(url);
  //   print(response.body);
  // }
}
