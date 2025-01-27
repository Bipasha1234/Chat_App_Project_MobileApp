import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @override
  List<Object?> get props => [id, fullName, profilePic, email, password];
  @JsonKey(name: '_id')
  final String? id;
  final String email;
  final String fullName;
  final String? password;
  final String? profilePic;

  const AuthApiModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.password,
    required this.profilePic,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //To entity
  AuthEntity toEntitiy() {
    return AuthEntity(
      userId: id,
      email: email,
      fullName: fullName,
      password: password ?? '',
    );
  }

  //from entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      email: entity.email,
      fullName: entity.fullName,
      password: entity.password,
      profilePic: entity.profilePic,
    );
  }
}
