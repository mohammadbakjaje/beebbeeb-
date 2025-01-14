abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<dynamic> orders;
  OrdersLoaded(this.orders);
}

class OrdersEmpty extends OrdersState {}

class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}
