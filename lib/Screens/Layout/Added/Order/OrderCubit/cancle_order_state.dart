abstract class CancelOrderState {}

class CancelOrderInitial extends CancelOrderState {}

class CancelOrderLoading extends CancelOrderState {}

class CancelOrderSuccess extends CancelOrderState {
  final String message;
  CancelOrderSuccess(this.message);
}

class CancelOrderFailure extends CancelOrderState {
  final String errorMessage;
  CancelOrderFailure(this.errorMessage);
}
