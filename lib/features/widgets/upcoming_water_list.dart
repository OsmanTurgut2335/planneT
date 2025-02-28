import 'package:flutter/material.dart';

class UpcomingWateringsList extends StatelessWidget {
  const UpcomingWateringsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek veri
    final upcomingWaterings = [
      {"plantName": "Monstera Deliciosa", "daysLeft": 2},
      {"plantName": "Yucca", "daysLeft": 5},
      {"plantName": "Cactus", "daysLeft": 1},
      {"plantName": "Cactus", "daysLeft": 1},
      {"plantName": "Yucca", "daysLeft": 1},
    ];

    // ListView.builder + shrinkWrap + NeverScrollableScrollPhysics
    // => Parent (SingleChildScrollView) içinde kaydırma kontrolü
    return SizedBox(
      height: 300,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: upcomingWaterings.length,
        itemBuilder: (context, index) {
          final item = upcomingWaterings[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.alarm, color: Colors.green, size: 30),
              title: Text(item["plantName"]?.toString() ?? "Bilinmiyor"),
              subtitle: Text("${item["daysLeft"]} gün içinde sulanmalı"),
              trailing: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  // Sulandı olarak işaretleme vb.
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
