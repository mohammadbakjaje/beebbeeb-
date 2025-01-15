import 'package:bloc/bloc.dart';
import 'package:untitled1/Screens/Driver/driver.dart';
import 'package:untitled1/Screens/Driver/register_driver/bloc_register/register_state_driver.dart';

import '../../../register/bloc/register_states.dart';
import '../../../register/model/register_model.dart';
import '../../../register/repos/register_server_manager.dart';
import '../repos_register/register_server_manager_driver.dart';

class DriverRegisterCubit extends Cubit<DriverRegisterState> {
  DriverRegisterCubit() : super(DriverInitialState());

  DriverRegisterServerManager registerServerManager =
      DriverRegisterServerManager();

  bool obscure = true;
  bool obscureConfirm = true;

  void registerBloc(String firstName, String lastName, String phone,
      String password, String confirmPassword) async {
    emit(DriverRegisterLoadingState());
    try {
      RegisterModel x = await registerServerManager.registerDriver(
          firstName, lastName, phone, password, confirmPassword);
      emit(DriverRegisterSuccessState());
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
