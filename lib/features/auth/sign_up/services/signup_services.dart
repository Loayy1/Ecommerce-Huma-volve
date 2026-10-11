import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_resp_model.dart';

import '../../../../core/network/api_client.dart';

class SignupServices {
  ApiClient apiClient;

  SignupServices(this.apiClient);

  Future<SignupRespModel> signUp(SignupReqModel signupModel) async {
    final resp = await apiClient.dio.post(
      ApiEndpoints.signupEndPoint,
      data: {
        "email": signupModel.email,
        "name": signupModel.name,
        "password": signupModel.password,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480",
      },
    );
    final jsonData = resp.data;
    final dartData = SignupRespModel.fromJson(jsonData);
    return dartData;
  }
}
