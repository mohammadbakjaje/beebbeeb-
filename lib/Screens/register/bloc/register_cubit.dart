import 'package:bloc/bloc.dart';

import '../model/register_model.dart';
import '../repos/register_server_manager.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialState());

  RegisterServerManager registerServerManager = RegisterServerManager();

  bool obscure = true;
  bool obscureConfirm = true;

  void registerBloc(String firstName, String lastName, String phone,
      String password, String confirmPassword) async {
    emit(RegisterLoadingState());
    try {
      RegisterModel x = await registerServerManager.register(
          firstName, lastName, phone, password, confirmPassword);
      emit(RegisterSuccessState(model: x));
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  void changePasswordState() {
    obscure = !obscure;
    emit(ChangePasswordState());
  }

  void changeConfirmPasswordState() {
    obscureConfirm = !obscureConfirm;
    emit(ChangePasswordState());
  }
}
