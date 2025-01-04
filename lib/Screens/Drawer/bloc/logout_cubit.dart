import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/logout_model.dart';
import '../repos/logout_server_manager.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(InitialState());

  LogoutServerManager logoutServerManager = LogoutServerManager();

  void logoutBloc(String token) async {
    emit(LogoutLoadingState());
    try {
      LogoutModel x = await logoutServerManager.logout(token);
      emit(LogoutSuccessState(model: x));
    } catch (e) {
      emit(LogoutErrorState(e.toString()));
    }
  }
}
