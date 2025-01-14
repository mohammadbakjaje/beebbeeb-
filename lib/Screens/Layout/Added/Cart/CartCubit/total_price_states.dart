abstract class TotalPriceState {}

class TotalPriceInitial extends TotalPriceState {}

class TotalPriceLoading extends TotalPriceState {}

class TotalPriceLoaded extends TotalPriceState {
  final double totalPrice;
  TotalPriceLoaded(this.totalPrice);
}

class TotalPriceError extends TotalPriceState {
  final String error;
  TotalPriceError(this.error);
}
