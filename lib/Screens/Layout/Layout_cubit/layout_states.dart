abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class GetUserDataLoadingState extends LayoutStates {}

class FailedToGetUserDataState extends LayoutStates {
  String? errMsg;
  FailedToGetUserDataState({required this.errMsg});
}

class GetUserDataSuccsesState extends LayoutStates {}

class ChangeBottomIndexNavState extends LayoutStates {}

class FavouriteLoadingState extends LayoutStates {}

class FavouriteLoadedState extends LayoutStates {
  final List<dynamic> favouriteProducts;
  FavouriteLoadedState(this.favouriteProducts);
}

class FavouriteErrorState extends LayoutStates {
  final String message;
  FavouriteErrorState(this.message);
}
