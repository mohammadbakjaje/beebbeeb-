abstract class StoreDetailsState {}

class StoreDetailsInitialState extends StoreDetailsState {}

class GetOneStoreLoadingState extends StoreDetailsState {}

class GetOneStoreSuccessState extends StoreDetailsState {}

class GetOneStoreFailedState extends StoreDetailsState {
  final String errorMsg;
  GetOneStoreFailedState(this.errorMsg);
}
