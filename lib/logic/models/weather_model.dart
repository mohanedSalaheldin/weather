class WeatherModel {
  String? city;
  String? desc;
  String? temp;
  WeatherModel(
    this.city,
    this.temp,
    this.desc,
  );
  WeatherModel.fromJson(Map<String, dynamic> json) {
    city = json['name'];
    desc = json['weather'][0]['description'];
    temp = json['main']['temp'].toString();
  }
}
