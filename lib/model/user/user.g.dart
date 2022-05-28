// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserRes _$$_UserResFromJson(Map json) => $checkedCreate(
      r'_$_UserRes',
      json,
      ($checkedConvert) {
        final val = _$_UserRes(
          id: $checkedConvert('id', (v) => v as String? ?? ''),
          email: $checkedConvert('email', (v) => v as String? ?? ''),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_UserResToJson(_$_UserRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
    };
