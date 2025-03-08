import 'package:allplant/core/constants/strings.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/repository/add_plant_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'add_plant_state.dart';

class AddPlantCubit extends Cubit<AddPlantState> {
  final AddPlantRepository plantRepository;

  AddPlantCubit(this.plantRepository) : super(AddPlantInitial());

  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  DateTime lastWateredDate = DateTime.now();
  int wateringFrequency = 7;
  String plantName = "";
  String? plantNickname;

  // 📷 Kamera veya Galeriden Resim Seçme
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        imagePath = pickedFile.path;
        emit(AddPlantImageSelected(imagePath!));
      }
    } catch (e) {
      emit(AddPlantFailure("Resim seçilirken hata oluştu"));
    }
  }

  // 📅 Tarih Seçme
  Future<void> selectDate(DateTime pickedDate) async {
    lastWateredDate = pickedDate;
    emit(AddPlantDateUpdated(lastWateredDate));
  }

  // 🌿 Bitki Adını Güncelle
  void setPlantName(String name) {
    plantName = name;
  }

  String? validatePlantName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.validationMessage;
    }
    return null;
  }

  // 🌿 Bitki Takma Adını Güncelle
  void setPlantNickname(String? nickname) {
    plantNickname = nickname;
  }

  // 💧 Sulama Sıklığını Güncelle
  void updateWateringFrequency(int frequency) {
    wateringFrequency = frequency;
    emit(AddPlantWateringUpdated(wateringFrequency));
  }

  // 🌱 Bitkiyi Kaydetme
  Future<void> savePlant() async {
    if (plantName.isEmpty) {
      emit(AddPlantFailure("Lütfen bitki adını girin!"));
      return;
    }

    if (imagePath == null) {
      emit(AddPlantFailure("Lütfen bir resim seçin!"));
      return;
    }

    final newPlant = Plant(
      name: plantName,
      nickname: plantNickname,
      imageUrl: imagePath!,
      lastWateredDate: lastWateredDate,
      wateringFrequencyInDays: wateringFrequency,
    );

    await plantRepository.addPlant(newPlant); // 📌 Repository'ye kayıt işlemi devredildi
    emit(AddPlantSuccess());
  }

  void validateAndSaveForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      savePlant();
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(AppStrings.takePhoto),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(AppStrings.selectFromGallery),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
}
