import 'package:bootcamp_clima/services/location.dart';
import 'package:bootcamp_clima/services/networking.dart';

const apiKey = 'e1c494c8f27d2bc4ba2cc821ee1d4bca';
const authorityOpenWeatherMapURL = 'api.openweathermap.org';
const unencodedPathOpenWeatherMapURL = '/data/2.5/weather';

/// unitOfMeasurement: standard/ metric/ imperial
const unitOfMeasurement = 'metric';

class WeatherModel {
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
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
