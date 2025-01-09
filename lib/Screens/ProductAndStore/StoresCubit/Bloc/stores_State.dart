abstract class StoresState {}

class StoresInitialState extends StoresState {}

class GetStoresLoadingState extends StoresState {}

class GetStoresSuccessState extends StoresState {}

class FilterStoresSuccessState extends StoresState {}

class GetStoresFailedState extends StoresState {
  final String errorMsg;
  GetStoresFailedState(this.errorMsg);
}