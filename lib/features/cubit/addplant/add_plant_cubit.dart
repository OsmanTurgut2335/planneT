import 'dart:io';
import 'package:allplant/features/models/plant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'add_plant_state.dart';

class AddPlantCubit extends Cubit<AddPlantState> {
  AddPlantCubit() : super(AddPlantInitial());

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

  // 🌿 Bitki Takma Adını Güncelle
  void setPlantNickname(String? nickname) {
    plantNickname = nickname;
  }

  // 💧 Sulama Sıklığını Güncelle
  void updateWateringFrequency(int frequency) {
    wateringFrequency = frequency;
    emit(AddPlantWateringUpdated(wateringFrequency));
  }

 // 🌱 Bitkiyi Hive'a Kaydetme
  void savePlant() async {
    if (plantName.isEmpty) {
      emit(AddPlantFailure("Lütfen bitki adını girin!"));
      return;
    }

    if (imagePath == null) {
      emit(AddPlantFailure("Lütfen bir resim seçin!"));
      return;
    }

    // 📌 Hive kutusunu aç
    final box = Hive.box<Plant>('plants');

    // 📌 Yeni bitkiyi oluştur
    final newPlant = Plant(
      name: plantName,
      nickname: plantNickname,
      imageUrl: imagePath!,
      lastWateredDate: lastWateredDate,
      wateringFrequencyInDays: wateringFrequency,
    );

    // 📌 Hive'a ekle
    await box.add(newPlant);

    print("Bitki Kaydedildi: $plantName, $plantNickname, $lastWateredDate, $wateringFrequency, $imagePath");

    emit(AddPlantSuccess());
  }
}
