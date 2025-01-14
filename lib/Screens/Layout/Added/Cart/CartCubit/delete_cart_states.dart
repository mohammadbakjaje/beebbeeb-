abstract class DeleteCartState {}

class DeleteCartInitial extends DeleteCartState {}

class DeleteCartLoading extends DeleteCartState {}

class DeleteCartSuccess extends DeleteCartState {
  final String message;
  DeleteCartSuccess(this.message);
}

class DeleteCartError extends DeleteCartState {
  final String error;
  DeleteCartError(this.error);
}
