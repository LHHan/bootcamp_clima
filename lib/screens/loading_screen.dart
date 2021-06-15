import 'package:bootcamp_clima/services/location.dart';
import 'package:bootcamp_clima/services/networking.dart';
import 'package:flutter/material.dart';

const apiKey = 'e1c494c8f27d2bc4ba2cc821ee1d4bca';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = new Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
      url: Uri.https('samples.openweathermap.org', '/data/2.5/weather', {
        'lat': latitude,
        'lon': longitude,
        'appid': apiKey,
      }),
    );

    var weatherData = await networkHelper.getData();
  }

  void getData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
