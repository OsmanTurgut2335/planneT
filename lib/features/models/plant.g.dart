// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantAdapter extends TypeAdapter<Plant> {
  @override
  final int typeId = 0;

  @override
  Plant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read()};
    return Plant(
      name: fields[0] as String,
      imageUrl: fields[1] as String,
      lastWateredDate: fields[2] as DateTime,
      wateringFrequencyInDays: fields[3] as int,
      nickname: fields[4] as String?,
      isWateredToday: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Plant obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.lastWateredDate)
      ..writeByte(3)
      ..write(obj.wateringFrequencyInDays)
      ..writeByte(4)
      ..write(obj.nickname)
      ..writeByte(5)
      ..write(obj.isWateredToday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PlantAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
