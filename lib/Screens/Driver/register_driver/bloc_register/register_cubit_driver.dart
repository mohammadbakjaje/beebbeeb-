import 'package:bloc/bloc.dart';
import 'package:untitled1/Screens/Driver/register_driver/bloc_register/register_state_driver.dart';

import '../model_register/register_model_driver.dart';
import '../repos_register/register_server_manager_driver.dart';

class DriverRegisterCubit extends Cubit<DriverRegisterState> {
  DriverRegisterCubit() : super(DriverInitialState());

  DriverRegisterServerManager driverRegisterServerManager = DriverRegisterServerManager();

  bool obscure = true;
  bool obscureConfirm = true;

  void registerDriver(String firstName, String lastName, String phone,
      String password, String confirmPassword) async {
    emit(DriverRegisterLoadingState());
    try {
      DriverRegisterModel x = await driverRegisterServerManager.registerDriver(
          firstName, lastName, phone, password, confirmPassword);
      emit(DriverRegisterSuccessState(model: x));
    } catch (e) {
      emit(DriverRegisterErrorState(e.toString()));
    }
  }

  void changePasswordState() {
    obscure = !obscure;
    emit(DriverChangePasswordState());
  }

  void changeConfirmPasswordState() {
    obscureConfirm = !obscureConfirm;
    emit(DriverChangePasswordState());
  }
}