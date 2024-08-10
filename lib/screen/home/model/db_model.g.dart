// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeminiDBModelAdapter extends TypeAdapter<GeminiDBModel> {
  @override
  final int typeId = 0;

  @override
  GeminiDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeminiDBModel(
      isQ: fields[0] as int,
      text: fields[1] as String,
      date: fields[2] as String,
      time: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GeminiDBModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isQ)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeminiDBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
