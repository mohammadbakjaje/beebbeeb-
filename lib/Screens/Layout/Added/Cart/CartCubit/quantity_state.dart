abstract class QuantityState {}

class QuantityInitial extends QuantityState {}

class QuantityLoading extends QuantityState {}

class QuantitySuccess extends QuantityState {
  final String message;
  QuantitySuccess(this.message);
}

class QuantityError extends QuantityState {
  final String error;
  QuantityError(this.error);
}
