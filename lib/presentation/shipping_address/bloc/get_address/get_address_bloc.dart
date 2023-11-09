import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/order_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/get_address_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_address_event.dart';
part 'get_address_state.dart';
part 'get_address_bloc.freezed.dart';

class GetAddressBloc extends Bloc<GetAddressEvent, GetAddressState> {
  GetAddressBloc() : super(const _Initial()) {
    on<_GetAddressByUserId>(
      (event, emit) async {
        emit(
          const _Loading(),
        );
        final result = await OrderRemoteDataSource().getAddressByUserId();
        result.fold(
          (l) => emit(
            _Error(l),
          ),
          (r) => emit(
            _Loaded(r),
          ),
        );
      },
    );
  }
}
