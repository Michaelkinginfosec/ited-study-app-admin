// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseEntityAdapter extends TypeAdapter<CourseEntity> {
  @override
  final int typeId = 1;

  @override
  CourseEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseEntity(
      courseName: fields[0] as String,
      courseTitle: fields[1] as String,
      courseCode: fields[2] as String,
      courseImage: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CourseEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.courseName)
      ..writeByte(1)
      ..write(obj.courseTitle)
      ..writeByte(2)
      ..write(obj.courseCode)
      ..writeByte(3)
      ..write(obj.courseImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
