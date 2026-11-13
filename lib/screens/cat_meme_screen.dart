import 'package:flutter/material.dart';

class CatMemeScreen extends StatefulWidget {
  const CatMemeScreen({super.key});

  @override
  State<CatMemeScreen> createState() => _CatMemeScreenState();
}

class _CatMemeScreenState extends State<CatMemeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _memeText = "¡Hola!";
  int _refreshKey = 0;

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://cataas.com/cat/says/$_memeText?key=$_refreshKey';

    return Scaffold(
      appBar: AppBar(title: const Text('Generador de Memes de Gatos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => 
                    const Text('Error al cargar la imagen del gato'),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Escribe tu frase para el meme',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _memeText = _controller.text.isEmpty ? 'Gato' : _controller.text;
                  _refreshKey++;
                });
              },
              child: const Text('Generar Meme'),
            ),
          ],
        ),
      ),
    );
  }
}