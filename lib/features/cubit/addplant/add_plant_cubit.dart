import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/repository/add_plant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'add_plant_state.dart';

class AddPlantCubit extends Cubit<AddPlantState> {
  final AddPlantRepository plantRepository;
  final ImagePicker _picker = ImagePicker();

  AddPlantCubit(this.plantRepository) : super(AddPlantState()); // start with defaults


  String? validatePlantName(String? value) {
    if (value == null || value.isEmpty) {
      return "Lütfen bitki adını girin!"; 
    }
    return null;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        emit(state.copyWith(imagePath: pickedFile.path));
      }
    } catch (e) {
      emit(state.copyWith(error: "Resim seçilirken hata oluştu"));
    }
  }

  void selectDate(DateTime pickedDate) {
    emit(state.copyWith(lastWateredDate: pickedDate));
  }

  void setPlantName(String name) {
    emit(state.copyWith(plantName: name));
  }

  void setPlantNickname(String? nickname) {
    emit(state.copyWith(plantNickname: nickname));
  }

  void updateWateringFrequency(int frequency) {
    emit(state.copyWith(wateringFrequency: frequency));
  }

  Future<void> savePlant() async {
    // Basic checks
    if (state.plantName.isEmpty) {
      emit(state.copyWith(error: "Lütfen bitki adını girin!"));
      return;
    }
    if (state.imagePath == null) {
      emit(state.copyWith(error: "Lütfen bir resim seçin!"));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));
      final newPlant = Plant(
        name: state.plantName,
        nickname: state.plantNickname,
        imageUrl: state.imagePath!,
        lastWateredDate: state.lastWateredDate,
        wateringFrequencyInDays: state.wateringFrequency,
      );
      await plantRepository.addPlant(newPlant);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
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
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Fotoğraf Çek"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Galeriden Seç"),
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
