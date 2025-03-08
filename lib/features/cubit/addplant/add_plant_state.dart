class AddPlantState {
  final String plantName;
  final String? plantNickname;
  final String? imagePath;
  final DateTime lastWateredDate;
  final int wateringFrequency;
  
  final bool isLoading;
  final bool isSuccess;
  final String? error;

 
   AddPlantState({
    this.plantName = '',
    this.plantNickname,
    this.imagePath,
    DateTime? lastWateredDate,
    this.wateringFrequency = 7,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  }) : lastWateredDate = lastWateredDate ?? DateTime.now();


  AddPlantState copyWith({
    String? plantName,
    String? plantNickname,
    String? imagePath,
    DateTime? lastWateredDate,
    int? wateringFrequency,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return AddPlantState(
      plantName: plantName ?? this.plantName,
      plantNickname: plantNickname ?? this.plantNickname,
      imagePath: imagePath ?? this.imagePath,
      lastWateredDate: lastWateredDate ?? this.lastWateredDate,
      wateringFrequency: wateringFrequency ?? this.wateringFrequency,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error, 
    );
  }
}
