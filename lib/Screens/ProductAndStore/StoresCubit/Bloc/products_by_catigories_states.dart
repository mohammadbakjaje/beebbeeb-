import '../../ProductsCubit/Bloc/products_models.dart';

abstract class ProductsByCatigoriesStatesState {}

class ProductsByCatigoriesInitialState
    extends ProductsByCatigoriesStatesState {}

class GetProductsByCatigoriesLoadingState
    extends ProductsByCatigoriesStatesState {}

class GetProductsByCatigoriesSuccessState
    extends ProductsByCatigoriesStatesState {
  final List<ProductModel> products;

  GetProductsByCatigoriesSuccessState(this.products);
}

class GetProductsByCatigoriesErrorState
    extends ProductsByCatigoriesStatesState {
  final String error;

  GetProductsByCatigoriesErrorState(this.error);
}
