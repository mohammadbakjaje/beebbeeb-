abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class GetProductsLoadingState extends ProductsState {}

class GetProductsSuccessState extends ProductsState {}

class FilterProductsSuccessState extends ProductsState {}

class GetProductsFailedState extends ProductsState {
  final String errorMsg;
  GetProductsFailedState(this.errorMsg);
}
