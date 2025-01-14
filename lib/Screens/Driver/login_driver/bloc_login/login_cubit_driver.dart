import 'package:flutter_bloc/flutter_bloc.dart';
import '../repos_login/register_server_manager_driver.dart';
import 'login_state_driver.dart';

class DriverLoginCubit extends Cubit<DriverLoginState> {
  DriverLoginCubit() : super(DriverLoginInitialState());

  DriverLoginServerManager driverLoginServerManager = DriverLoginServerManager();

  bool obscure = true;

  void LoginDriver(String email, String password, String license, String carType) async {
    emit(DriverLoginLoadingState());
    try {
      await driverLoginServerManager.loginDriver(email, password, license, carType);
      emit(DriverLoginSuccessState());
    } catch (e) {
      emit(DriverLoginErrorState(e.toString()));
    }
  }

  void changePasswordState() {
    obscure = !obscure;
    emit(DriverRegisterChangePasswordState());
  }
}