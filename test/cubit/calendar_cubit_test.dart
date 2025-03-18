// Cubit, State ve Repository dosyalarını import et
import 'package:allplant/core/cubit/calendar/calendar_cubit.dart';
import 'package:allplant/core/cubit/calendar/calendar_state.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_repositories.dart';



void main() {
  group('CalendarCubit tests', () {
    late CalendarCubit calendarCubit;
    late MockCalendarRepository mockRepository;

    setUp(() {
      mockRepository = MockCalendarRepository();
      
      calendarCubit = CalendarCubit(calendarRepository: mockRepository);
    });

    tearDown(() {
      calendarCubit.close();
    });


   test('initial state is PlantsCalenderInitial', () {
  final cubit = CalendarCubit(calendarRepository: mockRepository);
  expect(cubit.state, isA<PlantsCalenderInitial>());
});


    blocTest<CalendarCubit, CalendarState>(
      'emits [PlantsCalenderLoading, PlantsCalenderEmpty] when wateringSchedule is empty',
      build: () {
      
     when(() => mockRepository.loadWateringDates())
    .thenAnswer((_) async => <DateTime, List<String>>{});


        return calendarCubit;
      },
      act: (cubit) => cubit.loadWateringDates(),
      expect: () => [
        // İlk emit -> PlantsCalenderLoading
        isA<PlantsCalenderLoading>(),
        // Ardından boş map -> PlantsCalenderEmpty
        isA<PlantsCalenderEmpty>(),
      ],
    );

    blocTest<CalendarCubit, CalendarState>(
      'emits [PlantsCalenderLoading, PlantsCalenderLoaded] when wateringSchedule is not empty',
      build: () {
        // Repository'de loadWateringDates çağrıldığında dolu bir map dönsün
        
        when(() => mockRepository.loadWateringDates())
    .thenAnswer((_) async => <DateTime, List<String>>{
       DateTime(2025, 3, 17): ['Aloe Vera'],
    });

  
        return calendarCubit;
      },
      act: (cubit) => cubit.loadWateringDates(),
      expect: () => [
        isA<PlantsCalenderLoading>(),
        isA<PlantsCalenderLoaded>(), 
      ],
    );

    blocTest<CalendarCubit, CalendarState>(
      'emits [PlantsCalenderLoading, PlantsCalenderError] when an exception is thrown',
      build: () {

       when(() => mockRepository.loadWateringDates())
    .thenThrow(Exception('Some error'));

    
        return calendarCubit;
      },
      act: (cubit) => cubit.loadWateringDates(),
      expect: () => [
        isA<PlantsCalenderLoading>(),
        isA<PlantsCalenderError>(),
      ],
    );
  });
}
