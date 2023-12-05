import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_model.freezed.dart';

@freezed
abstract class UsersModel with _$UsersModel {
  factory UsersModel({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) = _UsersModel;

  factory UsersModel.fromJSON(Map<String, dynamic> json) => UsersModel(
        id: json['id'] as int?,
        email: json['email'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        avatar: json['avatar'] as String?,
      );
}
