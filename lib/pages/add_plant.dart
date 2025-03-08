// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:allplant/features/widgets/plant_type_dropdown.dart';
import 'package:allplant/features/widgets/watering_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allplant/core/constants/strings.dart';
import 'package:allplant/features/cubit/addplant/add_plant_cubit.dart';
import 'package:allplant/features/cubit/addplant/add_plant_state.dart';
import 'package:allplant/features/repository/add_plant_repository.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appBarTitle)),
      body: BlocProvider(
        create: (context) => AddPlantCubit(AddPlantRepository()),
        child: BlocConsumer<AddPlantCubit, AddPlantState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(AppStrings.successMessage)));
            } else if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddPlantCubit>();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: AppStrings.plantNameLabel,
                      validator: cubit.validatePlantName,
                      onSaved: (value) => cubit.setPlantName(value!),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(label: AppStrings.nicknameLabel, onSaved: (value) => cubit.setPlantNickname(value)),
                    const SizedBox(height: 15),
                    PlantTypeDropdown(
                      onSelected: (selectedType) {
                        context.read<AddPlantCubit>().setPlantType(selectedType);
                      },
                    ),
                    const SizedBox(height: 20),
                    // 💧 Watering Frequency Display and Slider
                    Text(
                      "${AppStrings.wateringFrequencyLabel} ${state.wateringFrequency} gün",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const WateringSlider(),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppStrings.lastWateredLabel} ${state.lastWateredDate.toString().split(' ')[0]}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today, color: Color(0xFF2B3D36)),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: state.lastWateredDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              cubit.selectDate(pickedDate);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // 📷 Image Picker
                    Center(
                      child: Column(
                        children: [
                          ImagePickerWidget(state: state),
                          TextButton.icon(
                            onPressed: () => cubit.showImagePicker(context),
                            icon: const Icon(Icons.image, color: Color(0xFF2B3D36)),
                            label: Text(AppStrings.selectImage, style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // 🌱 Save Button
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Center(
                        child: FloatingActionButton.extended(
                          onPressed: () => cubit.validateAndSaveForm(_formKey),
                          label: Text(AppStrings.savePlant),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextField({super.key, required this.label, this.validator, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(decoration: InputDecoration(labelText: label), validator: validator, onSaved: onSaved);
  }
}

class ImagePickerWidget extends StatelessWidget {
  final AddPlantState state;

  const ImagePickerWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.imagePath != null) {
      return Image.file(File(state.imagePath!), width: 200, height: 200);
    } else {
      return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
        child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
      );
    }
  }
}
