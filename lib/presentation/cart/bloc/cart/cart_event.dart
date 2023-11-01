part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.started() = _Started;
  const factory CartEvent.add(CartModel data) = _Add;
  const factory CartEvent.remove(CartModel data) = _Remove;
}
