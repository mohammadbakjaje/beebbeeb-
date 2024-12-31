import '../model/login_model.dart';

abstract class LoginState {}

class InitialState extends LoginState {}

class ChangePasswordState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  LoginModel model;
  LoginSuccessState({required this.model});
}

class LoginErrorState extends LoginState {
  String errorMsg;
  LoginErrorState(this.errorMsg);
}
