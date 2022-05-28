import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class UserRes with _$UserRes {
  const UserRes._();
  @JsonSerializable(
      anyMap: true, explicitToJson: true, checked: true, includeIfNull: false)
  const factory UserRes({
    @JsonKey(
      name: 'id',
      defaultValue: "",
    )
        required String id,
    @JsonKey(
      name: 'email',
      defaultValue: "",
    )
        required String email,
  }) = _UserRes;

  factory UserRes.fromJson(Map<String, dynamic> json) =>
      _$UserResFromJson(json);
}
