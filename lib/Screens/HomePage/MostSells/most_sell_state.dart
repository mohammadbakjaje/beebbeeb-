abstract class MostSellState {}

class MostSellInitial extends MostSellState {}

class MostSellLoading extends MostSellState {}

class MostSellLoaded extends MostSellState {
  final List<Map<String, dynamic>> products;
  MostSellLoaded(this.products);
}

class MostSellError extends MostSellState {
  final String message;
  MostSellError(this.message);
}
