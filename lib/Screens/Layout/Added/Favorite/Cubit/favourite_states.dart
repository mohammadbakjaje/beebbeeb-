abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  final List<dynamic> favouriteProducts;
  FavouriteLoadedState(this.favouriteProducts);
}

class FavouriteEmpity extends FavouriteState {}

class FavouriteErrorState extends FavouriteState {
  final String message;
  FavouriteErrorState(this.message);
}
