import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/order_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/requests/order_request_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Initial()) {
    on<_Order>((event, emit) async {
      emit(
        const _Loading(),
      );

      final response = await OrderRemoteDataSource().order(event.request);

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
