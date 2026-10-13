import 'package:ecommerce_app_huma_volve/features/auth/domain/entites/auth_token_entity.dart';

class LoginModel extends AuthTokenEntity {
  LoginModel({
    super.accessToken,
    super.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
}
