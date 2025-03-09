import 'dart:io';

import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/core/constants/strings.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onPickImage;

  const ImagePickerWidget({
    super.key,
    required this.imagePath,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (imagePath != null)
            Image.file(File(imagePath!), width: 200, height: 200)
          else
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
            ),
          TextButton.icon(
            onPressed: onPickImage,
            icon: const Icon(Icons.image, color: AppColors.deepPine),
            label: Text(AppStrings.selectImage, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
