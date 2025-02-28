
import 'package:allplant/features/widgets/myplants_listview_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold'ın body kısmını Stack ile oluşturuyoruz
      body: Stack(
        children: [
          // Arka plan rengi
          TopLeaf(),
          BottomLeaf(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(child: Text("Ana Ekran", style: Theme.of(context).textTheme.headlineLarge)),
              ),

              const SizedBox(height: 16),

              Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: PlantGuideSection())),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomLeaf extends StatelessWidget {
  const BottomLeaf({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Image.asset(
        'assets/images/leaf.png', // Yeni görselin path'i
        width: 200, // Boyutunu ihtiyacına göre ayarla
      ),
    );
  }
}

class TopLeaf extends StatelessWidget {
  const TopLeaf({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Image.asset(
        'assets/images/leaf_downwards.png',
        width: 200, // Boyutu ihtiyacına göre ayarla
      ),
    );
  }
}
