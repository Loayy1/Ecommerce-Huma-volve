import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import '../model/login_model.dart';
import '../model/signup_req_model.dart';
import '../model/signup_resp_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImp(this.apiClient);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final resp = await apiClient.dio.post(
      ApiEndpoints.loginEndPoint,
      data: {
        "email": email,
        "password": password,
      },
    );
    final Map<String, dynamic> data = resp.data;
    final modelData = LoginModel.fromJson(data);
    return modelData;
  }

  @override
  Future<SignupRespModel> signUp(SignupReqModel signupModel) async {
    final resp = await apiClient.dio.post(
      ApiEndpoints.signupEndPoint,
      data: signupModel.toJson(),
    );
    final jsonData = resp.data;
    final dartData = SignupRespModel.fromJson(jsonData);
    return dartData;
  }
}
