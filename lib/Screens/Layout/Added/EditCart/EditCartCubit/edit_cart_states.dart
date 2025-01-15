abstract class EditShowCartState {}

class EditShowCartInitial extends EditShowCartState {}

class EditShowCartLoaded extends EditShowCartState {
  final List<dynamic> cartItems;
  EditShowCartLoaded(this.cartItems);
}

class EditShowCartError extends EditShowCartState {
  final String error;
  EditShowCartError(this.error);
}

class EditShowCartEmpty extends EditShowCartState {}
