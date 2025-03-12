import 'dart:io';
import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/core/constants/paddings.dart';
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
    _fileExistsFuture = _checkImage(widget.plant.imageUrl);
  }

  Future<bool> _checkImage(String imageUrl) async {
    final file = File(imageUrl);
    final exists = await file.exists();
    if (exists) {
      precacheImage(FileImage(file), context);
    }
    return exists;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _fileExistsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingContainer();
        } else if (snapshot.hasError) {
          return const NoImageContainer();
        } else if (snapshot.hasData && snapshot.data == true) {
          final displayName = (widget.plant.nickname?.isNotEmpty ?? false) ? widget.plant.nickname : widget.plant.name;
          return PlantCardContent(plant: widget.plant, displayName: displayName);
        } else {
          return const NoImageContainer();
        }
      },
    );
  }
}

class PlantCardContent extends StatelessWidget {
  final Plant plant;
  final String? displayName;

  const PlantCardContent({super.key, required this.plant, required this.displayName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.imageSize / 2,
      margin: EdgeInsets.only(right: Constants.cardBorderRadius),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Constants.cardBorderRadius), color: AppColors.plantCardBackground),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(Constants.cardBorderRadius)),
              child: Image.file(
                File(plant.imageUrl),
                width: Constants.imageSize,
                height: Constants.imageSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Paddings.defaultPadding),
            decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(Constants.cardBorderRadius)),
            ),
            child: Text(displayName ?? "", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

class NoImageContainer extends StatelessWidget {
  const NoImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.imageSize,
      height: Constants.imageSize,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
      ),
      child: Center(child: Icon(Icons.image, size: (Constants.imageSize / 5), color: Colors.grey)),
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.imageSize,
      height: Constants.imageSize,
      color: Colors.grey.shade200,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class Constants {
  static const  imageSize = 250.0;
  static const   double cardBorderRadius = 12.0;
  static const  double containerMargin = 12.0;
}
