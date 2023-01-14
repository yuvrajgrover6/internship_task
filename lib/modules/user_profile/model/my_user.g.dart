// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyUserModelAdapter extends TypeAdapter<MyUserModel> {
  @override
  final int typeId = 0;

  @override
  MyUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyUserModel(
      id: fields[0] as String,
      name: fields[1] as String,
      atype: fields[2] as String,
      age: fields[3] as String,
      gender: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyUserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.atype)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
