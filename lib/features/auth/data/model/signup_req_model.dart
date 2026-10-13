import 'package:ecommerce_app_huma_volve/features/auth/domain/entites/signup_req_entity.dart';

class SignupReqModel extends SignupReqEntity {
  SignupReqModel({
    required super.name,
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "avatar": "https://api.lorem.space/image/face?w=640&h=480",
    };
  }
}
