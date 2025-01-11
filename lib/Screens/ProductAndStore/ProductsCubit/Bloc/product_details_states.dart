abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class GetOneProductLoadingState extends ProductDetailsState {}

class GetOneProductSuccessState extends ProductDetailsState {}

class GetOneProductFailedState extends ProductDetailsState {
  final String errorMsg;
  GetOneProductFailedState(this.errorMsg);
}

class FavouriteCheckedState extends ProductDetailsState {
  final bool isFavourite;
  FavouriteCheckedState(this.isFavourite);
}
