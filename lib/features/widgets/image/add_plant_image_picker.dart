import 'dart:io';

import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/core/constants/strings.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onPickImage;

  const ImagePickerWidget({super.key, required this.imagePath, required this.onPickImage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (imagePath != null)
            // Display the selected image using the centralized size.
            Image.file(File(imagePath!), width: ImagePickerConstants.imageSize, height: ImagePickerConstants.imageSize)
          else
            // Placeholder container with the same dimensions.
            Container(
              width: ImagePickerConstants.imageSize,
              height: ImagePickerConstants.imageSize,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(ImagePickerConstants.borderRadius),
              ),
              child: const Center(child: Icon(Icons.image, size: ImagePickerConstants.iconSize, color: Colors.grey)),
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

/// Centralized constants for the ImagePickerWidget.
class ImagePickerConstants {
  const ImagePickerConstants._();
  static const double imageSize = 200.0;
  static const double iconSize = 50.0;
  static const double borderRadius = 10.0;
}
