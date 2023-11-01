import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/product_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDataSource().getAllProduct();
      response.fold(
        (l) => emit(
          _Error(l),
        ),
        (r) => emit(
          _Loaded(r),
        ),
      );
    });
  }
}
