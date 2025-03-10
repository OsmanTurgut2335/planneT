import 'dart:io';

import 'package:flutter/material.dart';
import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:go_router/go_router.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            context.go('/plants');
          },
        ),
      ),
      backgroundColor: AppColors.alternateScaffoldBackground,
      body: Stack(
        children: [
          // 🌿 Background Image
          Positioned.fill(child: Image.file(File(plant.imageUrl), fit: BoxFit.cover)),
          Column(
            children: [
              const SizedBox(height: 200), // Space for the image
              // 🌱 Plant Info Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🌿 Plant Name & Type
                      Text(plant.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(plant.plantType, style: TextStyle(color: Colors.grey.shade600)),
                      const SizedBox(height: 16),

                      //     _buildPlantInfoRow(Icons.water_drop, "${plant.humidity ?? 30}%", "Humidity", true),
                      //   _buildPlantInfoRow(Icons.sunny, "${plant.light ?? 10}%", "Light", plant.light! > 20),
                      const SizedBox(height: 16),

                      // 📅 Care Schedule (Placeholder for future data)
                      const Text("Care schedule", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildCareSchedule(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🌡️ Builds an info row with icon, value, and label
  Widget _buildPlantInfoRow(IconData icon, String value, String label, bool isHealthy) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: isHealthy ? AppColors.deepPine : Colors.red),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: TextStyle(color: Colors.grey.shade600))),
          Icon(
            isHealthy ? Icons.sentiment_satisfied : Icons.sentiment_dissatisfied,
            color: isHealthy ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  // 📅 Placeholder Care Schedule
  Widget _buildCareSchedule() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        5,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: index == 3 ? Colors.green : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("${25 + index}"),
        ),
      ),
    );
  }
}
