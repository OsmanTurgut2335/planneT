import 'package:equatable/equatable.dart';


abstract class PlantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlantInitial extends PlantState {} // İlk yüklenme hali

class PlantLoading extends PlantState {} // Yükleme durumu

class PlantAdded extends PlantState {} // Başarıyla eklendi

class PlantError extends PlantState {
  final String message;
  PlantError(this.message);

  @override
  List<Object?> get props => [message];
}
