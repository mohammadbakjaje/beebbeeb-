abstract class AddRemoveFavouriteState {}

class AddRemoveFavouriteInitial extends AddRemoveFavouriteState {}

class AddFavouriteSuccessState extends AddRemoveFavouriteState {
  final String message;

  AddFavouriteSuccessState(this.message);
}

class RemoveFavouriteSuccessState extends AddRemoveFavouriteState {
  final String message;

  RemoveFavouriteSuccessState(this.message);
}

class FavouriteErrorState extends AddRemoveFavouriteState {
  final String message;

  FavouriteErrorState(this.message);
}
