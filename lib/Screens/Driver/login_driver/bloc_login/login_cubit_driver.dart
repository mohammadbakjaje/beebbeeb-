import 'package:flutter_bloc/flutter_bloc.dart';
import '../repos_login/register_server_manager_driver.dart';
import 'login_state_driver.dart';

class DriverLoginCubit extends Cubit<DriverLoginState> {
  DriverLoginCubit() : super(DriverLoginInitialState());

  DriverLoginServerManager driverLoginServerManager =
      DriverLoginServerManager();

  bool obscure = true;

  void DriverLoginDriver(String email, String password) async {
    emit(DriverLoginLoadingState());
    try {
      await driverLoginServerManager.DriverloginDriver(email, password);
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
