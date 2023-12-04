import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    String? fullName,
    String? email,
    String? gender,
    DateTime? birthDate,
    String? province,
    String? profilePhoto,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJSON(Map<String, dynamic> json) =>
      UserProfileModel(
        fullName: json['full_name'] as String?,
        email: json['email'] as String?,
        gender: json['gender'] as String?,
        birthDate: (json['birth_date'] as Timestamp).toDate(),
        province: json['province'] as String?,
        profilePhoto: json['profile_photo'] as String?,
      );
}
