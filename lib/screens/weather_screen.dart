import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = "Querétaro";
  Map<String, dynamic>? weatherData;
  bool isLoading = false;

  Future<void> fetchWeather(String cityName) async {
    setState(() => isLoading = true);
    const apiKey = '4820ded97ba91efaa0bfc8b58b131a23';
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric&lang=es');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima Minimalista')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : weatherData == null
                ? const Text('No se pudo cargar el clima (Revisa tu API Key)')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(weatherData!['name'], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text('${weatherData!['main']['temp']} °C', style: const TextStyle(fontSize: 64)),
                      Text('${weatherData!['weather'][0]['description']}', style: const TextStyle(fontSize: 20)),
                    ],
                  ),
      ),
    );
  }
}