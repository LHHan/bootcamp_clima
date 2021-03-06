import 'package:bootcamp_clima/services/location.dart';
import 'package:bootcamp_clima/services/networking.dart';

const apiKey = 'e1c494c8f27d2bc4ba2cc821ee1d4bca';
const authorityOpenWeatherMapURL = 'api.openweathermap.org';
const unencodedPathOpenWeatherMapURL = '/data/2.5/weather';

/// unitOfMeasurement: standard/ metric/ imperial
const unitOfMeasurement = 'metric';

class WeatherModel {
  Future<dynamic> getCityNameWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      url: Uri.https(
          authorityOpenWeatherMapURL, unencodedPathOpenWeatherMapURL, {
        'q': cityName,
        'appid': apiKey,
        'units': unitOfMeasurement,
      }),
    );

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
      url: Uri.https(
          authorityOpenWeatherMapURL, unencodedPathOpenWeatherMapURL, {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'appid': apiKey,
        'units': unitOfMeasurement,
      }),
    );

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
