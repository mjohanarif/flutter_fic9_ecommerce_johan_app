part of 'products_bloc.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.Loading() = _Loading;
  const factory ProductsState.Loaded(ProductResponseModel data) = _Loaded;
  const factory ProductsState.Error(String message) = _Error;
}
