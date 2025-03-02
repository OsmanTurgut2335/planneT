import 'dart:io';
import 'package:allplant/features/models/plant.dart';
import 'package:flutter/material.dart';

class PlantCard extends StatefulWidget {
  final Plant plant;
  const PlantCard({super.key, required this.plant});

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  late Future<bool> _fileExistsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fileExistsFuture = File(widget.plant.imageUrl).exists().then((exists) {
      if (exists) {
        // Dosya varsa resmi önbelleğe al
        precacheImage(FileImage(File(widget.plant.imageUrl)), context);
      }
      return exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _fileExistsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Yükleniyor göstergesi (veya boş container)
          return Container(
            width: 120,
            height: 160,
            color: Colors.grey.shade200,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          // Dosya mevcut, resmi göster
          final displayName = widget.plant.nickname?.isNotEmpty == true
              ? widget.plant.nickname
              : widget.plant.name;
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.file(
                      File(widget.plant.imageUrl),
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12)),
                  ),
                  child: Text(
                    displayName ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        } else {
          // Dosya bulunamadıysa placeholder göster
          return Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}
