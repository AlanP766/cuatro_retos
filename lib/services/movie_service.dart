import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
class MovieService {
  final String apiKey = '5bc7b4a32dde1c42195664ed9e99bc3d';

  Future<Movie> getRandomMovie() async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=es-MX');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      results.shuffle();
      return Movie.fromJson(results.first);
    } else {
      throw Exception('Error al cargar las películas');
    }
  }
}