import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/login_model.dart';
import '../repos/login_server_manager.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  LoginServerManager loginServerManager = LoginServerManager();

  bool obscure = true;

  void loginBloc(String email, String password) async {
    emit(LoginLoadingState());
    try {
      LoginModel x = await loginServerManager.login(email, password);
      emit(LoginSuccessState(model: x));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  void changePasswordState() {
    obscure = !obscure;
    emit(ChangePasswordState());
  }
}
