import 'package:allplant/core/cubit/addplant/add_plant_cubit.dart';
import 'package:allplant/core/cubit/addplant/add_plant_state.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_repositories.dart';

class FakePlant extends Fake implements Plant {}

//  Define fixed DateTime & “base” state
final _fixedDate = DateTime(2025, 1, 1);
final _baseState = AddPlantState(
  plantName: 'name',
  imagePath: '',
  lastWateredDate: _fixedDate,
);

//  Helper for expected states
AddPlantState expectedState({bool? isLoading, bool? isSuccess, String? error}) {
  return _baseState.copyWith(
    isLoading: isLoading,
    isSuccess: isSuccess,
    error: error,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePlant());
  });
  group('Add Plant Cubit Unit Tests', () {
    late AddPlantCubit addPlantCubit;
    late MockAddPlantRepository mockAddPlantRepository;

    setUp(() {
      mockAddPlantRepository = MockAddPlantRepository();
      addPlantCubit = AddPlantCubit(mockAddPlantRepository);
    });

    tearDown(() {
      addPlantCubit.close();
    });
    blocTest<AddPlantCubit, AddPlantState>(
      'emits [loading, success] when savePlant succeeds',
      build: () {
        when(
          () => mockAddPlantRepository.addPlant(any()),
        ).thenAnswer((_) async {});
        return addPlantCubit;
      },
      seed: () => _baseState,
      act: (c) => c.savePlant(),
      expect:
          () => [
            expectedState(isLoading: true),
            expectedState(isSuccess: true),
          ],
    );

    blocTest<AddPlantCubit, AddPlantState>(
      'emits [loading, error] when repository throws',
      build: () {
        when(
          () => mockAddPlantRepository.addPlant(any()),
        ).thenThrow(Exception('failed to save plant! '));
        return addPlantCubit;
      },
      seed: () => _baseState,
      act: (c) => c.savePlant(),
      expect:
          () => [
            expectedState(isLoading: true),
            expectedState(error: 'Exception: failed to save plant! '),
          ],
    );
    blocTest<AddPlantCubit, AddPlantState>(
      'emits error when repository throws for no plantName',
      build: () => addPlantCubit,
      seed: () => _baseState.copyWith(plantName: ''),
      act: (c) => c.savePlant(),
      expect:
          () => [
            expectedState(
              error: 'Lütfen bitki adını girin!',
            ).copyWith(plantName: ''),
          ],
    );
  });
}
