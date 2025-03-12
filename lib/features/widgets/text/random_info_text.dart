import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class DidYouKnowSection extends StatelessWidget {
  const DidYouKnowSection({super.key});

  Future<String> fetchRandomFact() async {
    // JSON dosyasını assets'ten yükle
    final String jsonString = await rootBundle.loadString('assets/data/facts.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // JSON içerisindeki verileri String listesine çevir
    final List<String> facts = jsonData.cast<String>();

    // Rastgele bir gerçek seçmek için karıştır
    facts.shuffle(Random());
    return facts.first;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchRandomFact(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Hata oluştu: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Bilgi bulunamadı."));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Bunu biliyor muydun ?", style: Theme.of(context).textTheme.titleMedium),
                Text(snapshot.data!, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          );
        }
      },
    );
  }
}
