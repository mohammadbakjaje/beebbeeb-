abstract class CheckIfFavouriteState {}

class CheckIfFavouriteInitial extends CheckIfFavouriteState {}

class CheckIfFavouriteLoading extends CheckIfFavouriteState {}

class FavouriteChecked extends CheckIfFavouriteState {
  final bool isFavourite;
  FavouriteChecked(this.isFavourite);
}

class FavouriteError extends CheckIfFavouriteState {
  final String errorMessage;
  FavouriteError(this.errorMessage);
}
