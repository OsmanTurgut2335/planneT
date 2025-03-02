import 'dart:io';
import 'package:allplant/features/cubit/plant_cubit.dart';
import 'package:allplant/features/cubit/plant_state.dart';
import 'package:allplant/features/models/plant.dart';
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

  // Kullanıcıdan alınacak veriler
  String _name = '';
  String? _nickname;
  DateTime _lastWateredDate = DateTime.now();
  int _wateringFrequency = 7;
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  // Resim Seçme Fonksiyonu
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  // Bitkiyi Kaydetme Fonksiyonu
  void _savePlant() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final plant = Plant(
        name: _name,
        imageUrl: _imagePath ?? '', // Kullanıcı resim eklemezse boş bırak
        lastWateredDate: _lastWateredDate,
        wateringFrequencyInDays: _wateringFrequency,
        nickname: _nickname,
      );

      context.read<PlantCubit>().addPlant(plant);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bitki Ekle")),
      body: BlocListener<PlantCubit, PlantState>(
        listener: (context, state) {
          if (state is PlantAdded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bitki başarıyla eklendi!")));
           
          } else if (state is PlantError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bitki Adı
                TextFormField(
                  decoration: const InputDecoration(labelText: "Bitki Adı"),
                  validator: (value) => value == null || value.isEmpty ? "Lütfen bitki adını girin" : null,
                  onSaved: (value) => _name = value!,
                ),
                const SizedBox(height: 10),

                // Takma Ad
                TextFormField(
                  decoration: const InputDecoration(labelText: "Takma Ad (Opsiyonel)"),
                  onSaved: (value) => _nickname = value,
                ),
                const SizedBox(height: 20),

                // Sulama Sıklığı Seçici (Slider)
                Text("Sulama Sıklığı: $_wateringFrequency gün", style: Theme.of(context).textTheme.bodySmall),
                Slider(
                  value: _wateringFrequency.toDouble(),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  label: _wateringFrequency.toString(),
                  onChanged: (value) {
                    setState(() {
                      _wateringFrequency = value.toInt();
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Son Sulama Tarihi Seçici
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Son Sulama: ${_lastWateredDate.toLocal()}".split(' ')[0],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _lastWateredDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _lastWateredDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Fotoğraf Seçme
                Center(
                  child: Column(
                    children: [
                      _imagePath != null
                          ? Image.file(File(_imagePath!), width: 250, height: 250, fit: BoxFit.cover)
                          : Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300, // Light gray background
                              borderRadius: BorderRadius.circular(10), // Optional rounded corners
                            ),
                            child: const Center(
                              child: Icon(Icons.image, size: 50, color: Colors.grey), // Placeholder icon
                            ),
                          ),

                      TextButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text("Resim Seç"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Kaydet Butonu
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Center(child: ElevatedButton(onPressed: _savePlant, child: const Text("Bitkiyi Kaydet"))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
