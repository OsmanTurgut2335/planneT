import 'package:equatable/equatable.dart';

class AddPlantState extends Equatable {
  AddPlantState({
    this.plantName = '',
    this.plantNickname,
    this.imagePath,
    DateTime? lastWateredDate,
    this.wateringFrequency = 7,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.plantType = 'Diğer',
  }) : lastWateredDate = lastWateredDate ?? DateTime.now();

  final String plantName;
  final String? plantNickname;
  final String? imagePath;
  final DateTime lastWateredDate;
  final int wateringFrequency;
  final bool isLoading;
  bool isSuccess;
  final String? error;
  final String plantType;

  AddPlantState copyWith({
    String? plantName,
    String? plantNickname,
    String? imagePath,
    DateTime? lastWateredDate,
    int? wateringFrequency,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? plantType,
  }) {
    return AddPlantState(
      plantName: plantName ?? this.plantName,
      plantNickname: plantNickname ?? this.plantNickname,
      imagePath: imagePath ?? this.imagePath,
      lastWateredDate: lastWateredDate ?? this.lastWateredDate,
      wateringFrequency: wateringFrequency ?? this.wateringFrequency,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      plantType: plantType ?? this.plantType,
    );
  }

  @override
  List<Object?> get props => [
    plantName,
    plantNickname,
    imagePath,
    lastWateredDate,
    wateringFrequency,
    isLoading,
    isSuccess,
    error,
    plantType,
  ];
}
