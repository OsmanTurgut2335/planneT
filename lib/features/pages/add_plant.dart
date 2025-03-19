import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/constants/strings.dart';
import 'package:allplant/core/cubit/addplant/add_plant_cubit.dart';
import 'package:allplant/core/cubit/addplant/add_plant_state.dart';
import 'package:allplant/core/repository/addplant/add_plant_repository.dart';
import 'package:allplant/features/widgets/calendar/add_plant_calendar.dart';
import 'package:allplant/features/widgets/image/add_plant_image_picker.dart';
import 'package:allplant/features/widgets/plant_type_dropdown.dart';
import 'package:allplant/features/widgets/text/add_plant_text_field.dart';
import 'package:allplant/features/widgets/watering_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text(AppStrings.appBarTitle),
      ),
      body: BlocProvider(
        create: (context) => AddPlantCubit(AddPlantRepository()),
        child: BlocListener<AddPlantCubit, AddPlantState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.successMessage)),
              );
              state.isSuccess = false;
              _formKey.currentState?.reset();
              context.read<AddPlantCubit>().resetState();
            } else if (state.error != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          child: BlocBuilder<AddPlantCubit, AddPlantState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(Paddings.defaultPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: AppStrings.plantNameLabel,
                        validator:
                            (value) => context
                                .read<AddPlantCubit>()
                                .validatePlantName(value),
                        onSaved:
                            (value) => context
                                .read<AddPlantCubit>()
                                .setPlantName(value!),
                      ),
                      const SizedBox(height: AddPlantConstants.smallSpacing),
                      CustomTextField(
                        label: AppStrings.nicknameLabel,
                        onSaved:
                            (value) => context
                                .read<AddPlantCubit>()
                                .setPlantNickname(value),
                      ),
                      const SizedBox(height: AddPlantConstants.smallSpacing),
                      PlantTypeDropdown(
                        onSelected: (selectedType) {
                          context.read<AddPlantCubit>().setPlantType(
                            selectedType,
                          );
                        },
                      ),
                      const SizedBox(height: AddPlantConstants.smallSpacing),
                      Text(
                        '${AppStrings.wateringFrequencyLabel} ${state.wateringFrequency} gün',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const WateringSlider(),
                      const SizedBox(height: AddPlantConstants.smallSpacing),
                      DatePickerWidget(
                        selectedDate: state.lastWateredDate,
                        onDateSelected: (date) {
                          context.read<AddPlantCubit>().selectDate(date);
                        },
                      ),
                      const SizedBox(height: AddPlantConstants.smallSpacing),
                      ImagePickerWidget(
                        imagePath: state.imagePath,
                        onPickImage: () => _onPickImage(context),
                      ),
                      const SizedBox(height: AddPlantConstants.smallSpacing),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: Paddings.largePadding,
                        ),
                        child: Center(
                          child: FloatingActionButton.extended(
                            onPressed:
                                () => context
                                    .read<AddPlantCubit>()
                                    .validateAndSaveForm(_formKey),
                            label: const Text(AppStrings.savePlant),
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
      ),
    );
  }

  void _onPickImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(AddPlantConstants.cameraText),
              onTap: () {
                Navigator.pop(context);
                context.read<AddPlantCubit>().pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(AddPlantConstants.galleryText),
              onTap: () {
                Navigator.pop(context);
                context.read<AddPlantCubit>().pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
}

class AddPlantConstants {
  const AddPlantConstants._();

  static const double smallSpacing = 10;
  static const double mediumSpacing = 12;

  static const String cameraText = 'Fotoğraf Çek';
  static const String galleryText = 'Galeriden Seç';

  static const String deleteTitle = 'Sil';
  static const String deleteContent =
      'Bitkiyi silmek istediğinize emin misiniz?';
  static const String cancelText = 'İptal';
  static const String confirmDeleteText = 'Sil';
}
