import 'dart:math';

import 'package:allplant/features/widgets/myplants_listview.dart';
import 'package:allplant/features/widgets/random_info_text.dart';

import 'package:allplant/features/widgets/upcoming_water_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //DUMMY DATA
  final randomFacts = [
    "Bitkiler oksijen üretir ve havayı temizler.",
    "Monstera Deliciosa'nın dev yaprakları doğal deliklere sahiptir.",
    "Kaktüsler su depolayarak kuraklığa dayanır.",
    "Orkide çiçekleri çok uzun süre canlı kalabilir.",
  ];

  late String selectedFact;

  @override
  void initState() {
    super.initState();
    final random = Random();
    selectedFact = randomFacts[random.nextInt(randomFacts.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan ve dekoratif görseller
          const TopLeaf(),
          const BottomLeaf(),

          // İçeriği kapsayan alan
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(child: Text("Ana Ekran", style: Theme.of(context).textTheme.headlineLarge)),
                ),
                const SizedBox(height: 16),

                // Üst kısım scrollable
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bitki Rehberi
                          PlantGuideSection(),

                          const SizedBox(height: 24),

                          Text("Yaklaşan Sulamalar", style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),

                          // Yaklaşan Sulamalar Listesi
                          const UpcomingWateringsList(),

                          DidYouKnowSection(info: selectedFact),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go('/add-plant'); // 🆕 Bitki ekleme ekranına yönlendir
        },
        icon: const Icon(Icons.add),
        label: const Text("Bitki Ekle"),
      ),
    );
  }
}

/// Üstteki yaprak görseli
class TopLeaf extends StatelessWidget {
  const TopLeaf({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(top: 0, left: 0, child: Image.asset('assets/images/leaf_downwards.png', width: 150));
  }
}

/// Alttaki yaprak görseli
class BottomLeaf extends StatelessWidget {
  const BottomLeaf({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(bottom: 0, right: 0, child: Image.asset('assets/images/leaf.png', width: 150));
  }
}
