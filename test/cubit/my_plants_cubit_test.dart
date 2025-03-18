import 'package:allplant/core/cubit/myplants/my_plants_cubit.dart';
import 'package:allplant/core/cubit/myplants/my_plants_state.dart';
import 'package:allplant/features/models/plant.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_repositories.dart';


void main() {
  group('My Plants Tests', () {
    late PlantListCubit plantListCubit;
    late MockMyPlantsRepository myPlantsRepository;

    setUp(() {
      myPlantsRepository = MockMyPlantsRepository();

      plantListCubit = PlantListCubit(repository: myPlantsRepository);
    });

    tearDown(() {
      plantListCubit.close();
    });

    blocTest<PlantListCubit, PlantListState>(
      'emits [PlantListEmpty] when repository.loadPlants returns an empty list',
      build: () {
        // Stublama: loadPlants() çağrıldığında boş bir liste döndür.
        when(() => myPlantsRepository.loadPlants()).thenReturn(<Plant>[]);
        // Cubit constructor'da loadPlants() çağırmıyor artık.
        return plantListCubit;
      },
      // Act aşamasında loadPlants() metodunu manuel çağırıyoruz.
      act: (cubit) => cubit.loadPlants(),
      // İlk state (PlantListLoading) initial state olarak kaldığı için, act'ten sonra emit edilen state'leri kontrol ediyoruz.
      expect: () => [isA<PlantListEmpty>()],
    );
    test('getWateringDates returns correct dates', () {
      final expectedDates = [DateTime(2025, 3, 17)];
      // Repository'nin getWateringDates() metodunun beklenen değeri döndürecek şekilde stub'lanması
      when(() => myPlantsRepository.getWateringDates()).thenReturn(expectedDates);

      final result = plantListCubit.getWateringDates();

      expect(result, equals(expectedDates));
    });
blocTest<PlantListCubit, PlantListState>(
  'emits [DeletePlantError] when deletePlant throws',
  build: () {
    // repository.deletePlant(any()) çağrıldığında Exception fırlat
    when(() => myPlantsRepository.deletePlant(any()))
      .thenThrow(Exception('delete failed'));

    // Cubit’i her test için yeni oluştur
    return PlantListCubit(repository: myPlantsRepository);
  },
  act: (cubit) => cubit.deletePlant(0),
  expect: () => [isA<DeletePlantError>()],
);




  });
}
