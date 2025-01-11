import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Bloc/stores_model.dart';

abstract class StoreDetailsState {}

class StoreDetailsInitialState extends StoreDetailsState {}

class GetStoreDetailsLoadingState extends StoreDetailsState {}

class GetStoreDetailsSuccessState extends StoreDetailsState {
  final StoreModel store;

  GetStoreDetailsSuccessState(this.store);
}

class GetStoreDetailsErrorState extends StoreDetailsState {
  final String error;

  GetStoreDetailsErrorState(this.error);
}
