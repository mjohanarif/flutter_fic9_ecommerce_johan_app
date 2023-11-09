import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/order_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/requests/add_address_request.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/add_address_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';
part 'add_address_bloc.freezed.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(const _Initial()) {
    on<_AddAddress>(
      (event, emit) async {
        emit(
          const _Loading(),
        );

        final result = await OrderRemoteDataSource().addAddress(event.request);

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
