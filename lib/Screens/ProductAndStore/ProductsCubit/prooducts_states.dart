abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class getProducatsLoadingState extends ProductsState {}

class getProducatsSuccessState extends ProductsState {}

class getProducatsFailedState extends ProductsState {
  String errorMsg;
  getProducatsFailedState(this.errorMsg);
}
