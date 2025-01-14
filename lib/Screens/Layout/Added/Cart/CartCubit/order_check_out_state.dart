abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final String message;
  CheckoutSuccess(this.message);
}

class CheckoutError extends CheckoutState {
  final String error;
  CheckoutError(this.error);
}
