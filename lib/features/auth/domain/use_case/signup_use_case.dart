import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entites/signup_req_entity.dart';
import '../entites/signup_resp_entity.dart';
import '../repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<Either<Failure, SignupRespEntity>> invoke(
    SignupReqEntity signupReq,
  ) =>
      authRepository.signUp(signupReq);
}
