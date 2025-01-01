import '../model/register_model.dart';

abstract class RegisterState {}

class InitialState extends RegisterState {}

class ChangePasswordState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  RegisterModel model;
  RegisterSuccessState({required this.model});
}

class RegisterErrorState extends RegisterState {
  String errorMsg;
  RegisterErrorState(this.errorMsg);
}
