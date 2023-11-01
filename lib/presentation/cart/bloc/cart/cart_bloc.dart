import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/widgets/cart_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const _Loaded([])) {
    on<_Add>((event, emit) {
      final currentState = state as _Loaded;

      final index = currentState.carts
          .indexWhere((element) => element.product.id == event.data.product.id);
      if (index >= 0) {
        currentState.carts[index].quantity++;
        emit(const _Loading());
        emit(
          _Loaded(
            currentState.carts,
          ),
        );
      } else {
        emit(
          _Loaded(
            [
              ...currentState.carts,
              event.data,
            ],
          ),
        );
      }
    });
    on<_Remove>((event, emit) {
      final currentState = state as _Loaded;

      final index = currentState.carts
          .indexWhere((element) => element.product.id == event.data.product.id);
      if (index >= 0) {
        currentState.carts[index].quantity--;
        if (currentState.carts[index].quantity <= 0) {
          List<CartModel> res = [];
          res.addAll(currentState.carts);
          res.removeAt(index);
          emit(const _Loading());
          emit(_Loaded(res));
        } else {
          emit(const _Loading());
          emit(_Loaded(currentState.carts));
        }
      }
    });
  }
}
