part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.started() = _Started;
  const factory CartEvent.add(CartModel data) = _Add;
  const factory CartEvent.removeItem(CartModel data) = _RemoveItem;
  const factory CartEvent.removeProduct(CartModel data) = _RemoveProduct;
}
