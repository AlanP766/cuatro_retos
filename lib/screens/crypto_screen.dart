import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final TextEditingController _usdController = TextEditingController();
  double usdAmount = 0.0;

  Future fetchCryptoPrices() async {
    const url = 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,solana&vs_currencies=usd';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fallo al obtener precios');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Convertidor Crypto en Tiempo Real')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: fetchCryptoPrices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final prices = snapshot.data as Map<String, dynamic>;
            double btcPrice = prices['bitcoin']['usd'].toDouble();
            double ethPrice = prices['ethereum']['usd'].toDouble();
            double solPrice = prices['solana']['usd'].toDouble();

            double btcBought = usdAmount > 0 ? usdAmount / btcPrice : 0.0;
            double ethBought = usdAmount > 0 ? usdAmount / ethPrice : 0.0;
            double solBought = usdAmount > 0 ? usdAmount / solPrice : 0.0;

            return Column(
              children: [
                TextField(
                  controller: _usdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Ingresa monto en USD (\$)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      usdAmount = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: const Text('Bitcoin (BTC)'),
                        subtitle: Text('Precio: \$ $btcPrice USD'),
                        trailing: Text('Comprarías: ${btcBought.toStringAsFixed(6)} BTC'),
                      ),
                      ListTile(
                        title: const Text('Ethereum (ETH)'),
                        subtitle: Text('Precio: \$ $ethPrice USD'),
                        trailing: Text('Comprarías: ${ethBought.toStringAsFixed(4)} ETH'),
                      ),
                      ListTile(
                        title: const Text('Solana (SOL)'),
                        subtitle: Text('Precio: \$ $solPrice USD'),
                        trailing: Text('Comprarías: ${solBought.toStringAsFixed(2)} SOL'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}