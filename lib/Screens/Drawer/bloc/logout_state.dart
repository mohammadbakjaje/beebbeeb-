import '../model/logout_model.dart';

abstract class LogoutState {}

class InitialState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutSuccessState extends LogoutState {
  LogoutModel model;
  LogoutSuccessState({required this.model});
}

class LogoutErrorState extends LogoutState {
  String errorMsg;
  LogoutErrorState(this.errorMsg);
}
