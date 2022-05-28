// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserRes _$UserResFromJson(Map<String, dynamic> json) {
  return _UserRes.fromJson(json);
}

/// @nodoc
mixin _$UserRes {
  @JsonKey(name: 'id', defaultValue: "")
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'email', defaultValue: "")
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserResCopyWith<UserRes> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserResCopyWith<$Res> {
  factory $UserResCopyWith(UserRes value, $Res Function(UserRes) then) =
      _$UserResCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id', defaultValue: "") String id,
      @JsonKey(name: 'email', defaultValue: "") String email});
}

/// @nodoc
class _$UserResCopyWithImpl<$Res> implements $UserResCopyWith<$Res> {
  _$UserResCopyWithImpl(this._value, this._then);

  final UserRes _value;
  // ignore: unused_field
  final $Res Function(UserRes) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserResCopyWith<$Res> implements $UserResCopyWith<$Res> {
  factory _$$_UserResCopyWith(
          _$_UserRes value, $Res Function(_$_UserRes) then) =
      __$$_UserResCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id', defaultValue: "") String id,
      @JsonKey(name: 'email', defaultValue: "") String email});
}

/// @nodoc
class __$$_UserResCopyWithImpl<$Res> extends _$UserResCopyWithImpl<$Res>
    implements _$$_UserResCopyWith<$Res> {
  __$$_UserResCopyWithImpl(_$_UserRes _value, $Res Function(_$_UserRes) _then)
      : super(_value, (v) => _then(v as _$_UserRes));

  @override
  _$_UserRes get _value => super._value as _$_UserRes;

  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
  }) {
    return _then(_$_UserRes(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(
    anyMap: true, explicitToJson: true, checked: true, includeIfNull: false)
class _$_UserRes extends _UserRes {
  const _$_UserRes(
      {@JsonKey(name: 'id', defaultValue: "") required this.id,
      @JsonKey(name: 'email', defaultValue: "") required this.email})
      : super._();

  factory _$_UserRes.fromJson(Map<String, dynamic> json) =>
      _$$_UserResFromJson(json);

  @override
  @JsonKey(name: 'id', defaultValue: "")
  final String id;
  @override
  @JsonKey(name: 'email', defaultValue: "")
  final String email;

  @override
  String toString() {
    return 'UserRes(id: $id, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserRes &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(email));

  @JsonKey(ignore: true)
  @override
  _$$_UserResCopyWith<_$_UserRes> get copyWith =>
      __$$_UserResCopyWithImpl<_$_UserRes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserResToJson(this);
  }
}

abstract class _UserRes extends UserRes {
  const factory _UserRes(
      {@JsonKey(name: 'id', defaultValue: "")
          required final String id,
      @JsonKey(name: 'email', defaultValue: "")
          required final String email}) = _$_UserRes;
  const _UserRes._() : super._();

  factory _UserRes.fromJson(Map<String, dynamic> json) = _$_UserRes.fromJson;

  @override
  @JsonKey(name: 'id', defaultValue: "")
  String get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'email', defaultValue: "")
  String get email => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserResCopyWith<_$_UserRes> get copyWith =>
      throw _privateConstructorUsedError;
}
