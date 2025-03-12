import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DidYouKnowSection extends StatelessWidget {
  const DidYouKnowSection({super.key});

  Future<String> fetchRandomFact() async {
    final String jsonString = await rootBundle.loadString('assets/data/facts.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    final List<String> facts = jsonData.cast<String>();
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
          return Center(
            child: Text(
              '${DidYouKnowStrings.errorPrefix} ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text(DidYouKnowStrings.noData));
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              children: [
                Text(DidYouKnowStrings.title, style: Theme.of(context).textTheme.titleMedium),
                Text(snapshot.data!, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          );
        }
      },
    );
  }
}

class DidYouKnowStrings {
  DidYouKnowStrings._(); // private constructor prevents instantiation

  static const String title = "Bunu biliyor muydun ?";
  static const String errorPrefix = "Hata oluştu:";
  static const String noData = "Bilgi bulunamadı.";
}
