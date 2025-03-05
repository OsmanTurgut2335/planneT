import 'dart:io';
import 'package:allplant/features/cubit/addplant/add_plant_cubit.dart';
import 'package:allplant/features/cubit/addplant/add_plant_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(title: const Text("Bitki Ekle")),
      body: BlocProvider(
        create: (context) => AddPlantCubit(),
        child: BlocConsumer<AddPlantCubit, AddPlantState>(
          listener: (context, state) {
            if (state is AddPlantSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bitki başarıyla eklendi!")));
            } else if (state is AddPlantFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
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
                    // 🌿 Bitki Adı
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Bitki Adı"),
                      validator: (value) => value == null || value.isEmpty ? "Lütfen bitki adını girin" : null,
                      onSaved: (value) => cubit.setPlantName(value!),
                    ),
                    const SizedBox(height: 10),

                    // 🌿 Takma Ad (Opsiyonel)
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Takma Ad (Opsiyonel)"),
                      onSaved: (value) => cubit.setPlantNickname(value),
                    ),
                    const SizedBox(height: 20),

                    // 💧 Sulama Sıklığı
                    Text(
                      "Sulama Sıklığı: ${cubit.wateringFrequency} gün",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Slider(
                      value: cubit.wateringFrequency.toDouble(),
                      min: 1,
                      max: 30,
                      divisions: 29,
                      label: cubit.wateringFrequency.toString(),
                      onChanged: (value) => cubit.updateWateringFrequency(value.toInt()),
                    ),
                    const SizedBox(height: 10),

                    // 📅 Son Sulama Tarihi Seçici
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Son sulama: ${cubit.lastWateredDate.toString().split(' ')[0]}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),

                        IconButton(
                          icon: const Icon(Icons.calendar_today, color: Colors.green),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: cubit.lastWateredDate,
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
                    const SizedBox(height: 10),

                    // 📷 Resim Seçme
                    Center(
                      child: Column(
                        children: [
                          state is AddPlantImageSelected
                              ? Image.file(File(state.imagePath), width: 250, height: 250)
                              : Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                              ),
                          TextButton.icon(
                            onPressed: () => _showImageSourceDialog(context, cubit),
                            icon: const Icon(Icons.image),
                            label: const Text("Fotoğraf Seç"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🌱 Kaydet Butonu
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              cubit.savePlant();
                            }
                          },
                          child: const Text("Bitkiyi Kaydet"),
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

  void _showImageSourceDialog(BuildContext context, AddPlantCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Kameradan Çek"),
              onTap: () {
                Navigator.pop(context);
                cubit.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Galeriden Seç"),
              onTap: () {
                Navigator.pop(context);
                cubit.pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
}
