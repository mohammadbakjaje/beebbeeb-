abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

// حالات ProductsCubit
class GetProductsLoadingState extends ProductsState {}

class GetProductsSuccessState extends ProductsState {}

class GetProductsFailedState extends ProductsState {
  final String errorMsg;
  GetProductsFailedState(this.errorMsg);
}
