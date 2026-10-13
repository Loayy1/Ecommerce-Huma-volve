import 'package:ecommerce_app_huma_volve/features/auth/domain/entites/signup_resp_entity.dart';

class SignupRespModel extends SignupRespEntity {
  SignupRespModel({
    super.id,
    super.email,
    super.password,
    super.name,
    super.role,
    super.avatar,
    super.creationAt,
    super.updatedAt,
  });

  factory SignupRespModel.fromJson(Map<String, dynamic> json) {
    return SignupRespModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '',
      creationAt: json['creationAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
