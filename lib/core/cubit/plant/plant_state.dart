import 'package:equatable/equatable.dart';


abstract class PlantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlantInitial extends PlantState {} 

class PlantLoading extends PlantState {} 

class PlantAdded extends PlantState {} 

class PlantError extends PlantState {
  PlantError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
