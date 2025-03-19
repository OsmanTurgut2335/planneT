import 'package:allplant/core/cubit/watering/watering_cubit.dart';
import 'package:allplant/core/cubit/watering/watering_state.dart';
import 'package:allplant/core/repository/watering/water_repository.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/models/upcoming_event.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_repositories.dart';

class FakePlant extends Fake implements Plant {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePlant());
  });
  group('Upcoming Watering Tests', () {
    late TodaysWateringsCubit todaysWateringsCubit;
    late WateringRepository wateringRepository;
    setUp(() async {
      await setUpTestHive();

      wateringRepository = MockWateringRepository();
      todaysWateringsCubit = TodaysWateringsCubit(
        repository: wateringRepository,
      );
    });

    tearDown(() {
      todaysWateringsCubit.close();
    });

    blocTest<TodaysWateringsCubit, WateringState>(
      'Emits TodaysWateringsLoaded when getUpcomingWaterings returns non-empty list',
      build: () {
        final now = DateTime.now();
        final normalizedToday = DateTime(now.year, now.month, now.day);

        final dummyPlant = Plant(
          name: 'Test Plant',
          lastWateredDate: normalizedToday,
          wateringFrequencyInDays: 3,
          imageUrl: '',
        );
        final wateringEvent = WateringEvent(
          plant: dummyPlant,
          wateringDate: normalizedToday,
        );

        when(
          () => wateringRepository.getUpcomingWaterings(),
        ).thenAnswer((_) async => [wateringEvent]);

        return todaysWateringsCubit;
      },
      act: (cubit) => cubit.loadUpcomingWaterings(),
      expect:
          () => [isA<TodaysWateringsLoading>(), isA<TodaysWateringsLoaded>()],
    );

    blocTest<TodaysWateringsCubit, WateringState>(
      'emits wateringlistempty when loadwaterings returns empty list',
      build: () {
        when(
          () => wateringRepository.getUpcomingWaterings(),
        ).thenAnswer((_) async => []);

        return todaysWateringsCubit;
      },
      act: (cubit) {
        cubit.loadUpcomingWaterings();
      },
      expect:
          () => [isA<TodaysWateringsLoading>(), isA<TodaysWateringsEmpty>()],
    );

    blocTest<TodaysWateringsCubit, WateringState>(
      'emits error when loadwaterings fails',
      build: () {
        when(
          () => wateringRepository.getUpcomingWaterings(),
        ).thenThrow('Error loading upcoming waterings: ');

        return todaysWateringsCubit;
      },

      act: (cubit) => cubit.loadUpcomingWaterings(),

      expect:
          () => [isA<TodaysWateringsLoading>(), isA<TodaysWateringsError>()],
    );
  });
}
