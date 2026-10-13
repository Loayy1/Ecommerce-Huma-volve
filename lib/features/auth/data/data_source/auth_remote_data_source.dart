import '../model/login_model.dart';
import '../model/signup_req_model.dart';
import '../model/signup_resp_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({
    required String email,
    required String password,
  });

  Future<SignupRespModel> signUp(SignupReqModel signupModel);
}
