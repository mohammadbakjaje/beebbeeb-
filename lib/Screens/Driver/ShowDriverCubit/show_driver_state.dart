abstract class InProgressOrdersState {}

class InProgressOrdersInitial extends InProgressOrdersState {}

class InProgressOrdersLoading extends InProgressOrdersState {}

class InProgressOrdersLoaded extends InProgressOrdersState {
  final List<dynamic> orders;
  InProgressOrdersLoaded(this.orders);
}

class InProgressOrdersError extends InProgressOrdersState {
  final String message;
  InProgressOrdersError(this.message);
}
