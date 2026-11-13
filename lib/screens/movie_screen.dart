import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart'; 

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final MovieService _movieService = MovieService();
  late Future<Movie> _randomMovie;

  @override
  void initState() {
    super.initState();
    _randomMovie = _movieService.getRandomMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recomendador de Películas')),
      body: FutureBuilder<Movie>(
        future: _randomMovie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final movie = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (movie.posterPath.isNotEmpty)
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(movie.posterPath, fit: BoxFit.cover),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  movie.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _randomMovie = _movieService.getRandomMovie();
                    });
                  },
                  child: const Text('Otra Película'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}