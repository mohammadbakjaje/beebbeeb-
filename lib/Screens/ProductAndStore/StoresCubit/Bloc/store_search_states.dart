abstract class SearchStoreStates {}

class SearchStoreInitial extends SearchStoreStates {}

class SearchStoreLoading extends SearchStoreStates {}

class SearchStoreSuccess extends SearchStoreStates {
  final List<dynamic> data;
  SearchStoreSuccess(this.data);
}

class SearchStoreError extends SearchStoreStates {
  final String message;
  SearchStoreError(this.message);
}
