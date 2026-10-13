import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entites/auth_token_entity.dart';
import '../entites/signup_req_entity.dart';
import '../entites/signup_resp_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, SignupRespEntity>> signUp(
    SignupReqEntity signupReq,
  );
}
