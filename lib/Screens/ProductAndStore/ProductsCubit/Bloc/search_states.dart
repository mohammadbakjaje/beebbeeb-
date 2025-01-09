abstract class SearchStates {}

class SearchInitial extends SearchStates {}

class SearchLoading extends SearchStates {}

class SearchSuccess extends SearchStates {
  final List<dynamic> data;
  SearchSuccess(this.data);
}

class SearchError extends SearchStates {
  final String message;
  SearchError(this.message);
}
