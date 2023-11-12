import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/product_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';
part 'search_product_bloc.freezed.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  SearchProductBloc()
      : super(
          const _Initial(),
        ) {
    on<_SearchProduct>((event, emit) async {
      emit(
        const _Loading(),
      );

      final response = await ProductRemoteDataSource().getSearchProduct(
        event.query,
      );

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
