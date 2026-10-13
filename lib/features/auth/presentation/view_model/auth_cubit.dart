import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entites/signup_req_entity.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/signup_use_case.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await loginUseCase.invoke(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        emit(LoginFailed(failure.failureMessage));
      },
      (data) {
        emit(LoginSuccess(data));
      },
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    final result = await signUpUseCase.invoke(
      SignupReqEntity(
        name: name,
        email: email,
        password: password,
      ),
    );
    result.fold(
      (failure) {
        emit(SignUpFailed(failure.failureMessage));
      },
      (data) {
        emit(SignUpSuccess(data));
      },
    );
  }
}
