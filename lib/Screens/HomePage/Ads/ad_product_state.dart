abstract class AdProductState {}

class AdProductInitial extends AdProductState {}

class AdProductLoading extends AdProductState {}

class AdProductLoaded extends AdProductState {
  final List<Map<String, dynamic>> products;
  final List<String> images; // قائمة روابط الصور
  AdProductLoaded(this.products, this.images);
}

class AdProductError extends AdProductState {
  final String message;
  AdProductError(this.message);
}
