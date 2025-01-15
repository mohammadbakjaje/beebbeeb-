import '../model_register/register_model_driver.dart';

abstract class DriverRegisterState {}

class DriverInitialState extends DriverRegisterState {}

class DriverChangePasswordState extends DriverRegisterState {}

class DriverRegisterLoadingState extends DriverRegisterState {}

class DriverRegisterSuccessState extends DriverRegisterState {}

class DriverRegisterErrorState extends DriverRegisterState {
  String errorMsg;
  DriverRegisterErrorState(this.errorMsg);
}
