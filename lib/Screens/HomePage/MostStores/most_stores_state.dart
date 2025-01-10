abstract class MostStoresState {}

class StoresInitial extends MostStoresState {}

class StoresLoading extends MostStoresState {}

class StoresLoaded extends MostStoresState {
  final List<Map<String, dynamic>> stores;
  StoresLoaded(this.stores);
}

class StoresError extends MostStoresState {
  final String message;
  StoresError(this.message);
}
