import '../../domain/entites/auth_token_entity.dart';
import '../../domain/entites/signup_resp_entity.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {
  final AuthTokenEntity tokenEntity;

  LoginSuccess(this.tokenEntity);
}

class LoginFailed extends AuthStates {
  final String errorMsg;

  LoginFailed(this.errorMsg);
}

class SignUpLoading extends AuthStates {}

class SignUpSuccess extends AuthStates {
  final SignupRespEntity userEntity;

  SignUpSuccess(this.userEntity);
}

class SignUpFailed extends AuthStates {
  final String errorMsg;

  SignUpFailed(this.errorMsg);
}
