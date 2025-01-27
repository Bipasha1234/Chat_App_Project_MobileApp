// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      password: json['password'] as String?,
      profilePic: json['profilePic'] as String?,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'password': instance.password,
      'profilePic': instance.profilePic,
    };
