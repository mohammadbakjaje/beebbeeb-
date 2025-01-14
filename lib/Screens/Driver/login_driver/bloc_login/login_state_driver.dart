abstract class DriverLoginState {}

class DriverLoginInitialState extends DriverLoginState {}

class DriverLoginLoadingState extends DriverLoginState {}

class DriverLoginSuccessState extends DriverLoginState {}

class DriverLoginErrorState extends DriverLoginState {
  final String errorMsg;
  DriverLoginErrorState(this.errorMsg);
}

class DriverRegisterChangePasswordState extends DriverLoginState {}