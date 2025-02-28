import 'package:hive/hive.dart';

part 'plant.g.dart';

@HiveType(typeId: 0)
class Plant extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final DateTime lastWateredDate;

  @HiveField(3)
  final int wateringFrequencyInDays;

  // Yeni alan: Nullable nickname
  @HiveField(4)
  final String? nickname;

  Plant({
    required this.name,
    required this.imageUrl,
    required this.lastWateredDate,
    required this.wateringFrequencyInDays,
    this.nickname, // nullable olduğu için required değil
  });

  int get daysUntilNextWatering {
    final nextWateringDate = lastWateredDate.add(Duration(days: wateringFrequencyInDays));
    final remainingDays = nextWateringDate.difference(DateTime.now()).inDays;
    return remainingDays > 0 ? remainingDays : 0;
  }
}
