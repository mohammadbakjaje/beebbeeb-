abstract class UpdateUserState {}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final String message;
  UpdateUserSuccess(this.message);
}

class UpdateUserFailure extends UpdateUserState {
  final String error;
  UpdateUserFailure(this.error);
}
