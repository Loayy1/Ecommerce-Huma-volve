import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/errors_handling.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entites/auth_token_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entites/signup_req_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entites/signup_resp_entity.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../model/signup_req_model.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImp(this.authRemoteDataSource);

  @override
  Future<Either<Failure, AuthTokenEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginModel = await authRemoteDataSource.login(
        email: email,
        password: password,
      );
      await SecureStorage.saveAccessToken(loginModel.accessToken);
      await SecureStorage.saveRefreshToken(loginModel.refreshToken);
      return Right(loginModel);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, SignupRespEntity>> signUp(
    SignupReqEntity signupReq,
  ) async {
    try {
      final reqModel = SignupReqModel(
        name: signupReq.name,
        email: signupReq.email,
        password: signupReq.password,
      );
      final resp = await authRemoteDataSource.signUp(reqModel);
      return Right(resp);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
