abstract class AddPlantState {}

class AddPlantInitial extends AddPlantState {}

class AddPlantLoading extends AddPlantState {}

class AddPlantSuccess extends AddPlantState {}

class AddPlantFailure extends AddPlantState {
  final String error;
  AddPlantFailure(this.error);
}

class AddPlantImageSelected extends AddPlantState {
  final String imagePath;
  AddPlantImageSelected(this.imagePath);
}

class AddPlantDateUpdated extends AddPlantState {
  final DateTime lastWateredDate;
  AddPlantDateUpdated(this.lastWateredDate);
}

class AddPlantWateringUpdated extends AddPlantState {
  final int wateringFrequency;
  AddPlantWateringUpdated(this.wateringFrequency);
}
