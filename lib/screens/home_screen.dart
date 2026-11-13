import 'package:flutter/material.dart';
import 'movie_screen.dart';
import 'cat_meme_screen.dart';
import 'weather_screen.dart';
import 'crypto_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Los Cuatro Retos de Flutter'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _MenuButton(
            title: 'Reto 1: Recomendador de Películas',
            subtitle: 'TMDB / OMDb API y Tarjetas',
            icon: Icons.movie,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MovieScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _MenuButton(
            title: 'Reto 2: Memes de Gatos',
            subtitle: 'Cataas API y URLs dinámicas con Texto',
            icon: Icons.pets,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CatMemeScreen()), // Sin const
              );
            },
          ),
          const SizedBox(height: 12),
          _MenuButton(
            title: 'Reto 3: Clima Minimalista',
            subtitle: 'OpenWeatherMap y Geolocalización',
            icon: Icons.wb_sunny,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WeatherScreen()), // Sin const
              );
            },
          ),
          const SizedBox(height: 12),
          _MenuButton(
            title: 'Reto 4: Convertidor de Criptomonedas',
            subtitle: 'CoinGecko API y FutureBuilder',
            icon: Icons.currency_bitcoin,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CryptoScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue.shade800),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}