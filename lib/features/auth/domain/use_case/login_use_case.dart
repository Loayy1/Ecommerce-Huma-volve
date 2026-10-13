import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entites/auth_token_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Either<Failure, AuthTokenEntity>> invoke({
    required String email,
    required String password,
  }) =>
      authRepository.login(email: email, password: password);
}
