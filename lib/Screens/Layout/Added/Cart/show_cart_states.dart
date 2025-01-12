abstract class ShowCartState {}

class ShowCartInitial extends ShowCartState {}

class ShowCartLoading extends ShowCartState {}

class ShowCartLoaded extends ShowCartState {
  final List<dynamic> cartItems;
  ShowCartLoaded(this.cartItems);
}

class ShowCartError extends ShowCartState {
  final String error;
  ShowCartError(this.error);
}

class ShowCartEmpty extends ShowCartState {}
