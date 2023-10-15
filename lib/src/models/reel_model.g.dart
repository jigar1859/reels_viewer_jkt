// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReelModelAdapter extends TypeAdapter<ReelModel> {
  @override
  final int typeId = 1;

  @override
  ReelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReelModel(
      fields[1] as String,
      fields[4] as String,
      id: fields[0] as String?,
      profileUrl: fields[5] as String?,
      reelDescription: fields[6] as String?,
      musicName: fields[7] as String?,
      commentList: (fields[8] as List?)?.cast<ReelCommentModel>(),
      isLiked: fields[2] as bool,
      likeCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReelModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.isLiked)
      ..writeByte(3)
      ..write(obj.likeCount)
      ..writeByte(4)
      ..write(obj.userName)
      ..writeByte(5)
      ..write(obj.profileUrl)
      ..writeByte(6)
      ..write(obj.reelDescription)
      ..writeByte(7)
      ..write(obj.musicName)
      ..writeByte(8)
      ..write(obj.commentList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
