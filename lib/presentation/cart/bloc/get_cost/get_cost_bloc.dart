import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/raja_ongkir_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/const_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_cost_event.dart';
part 'get_cost_state.dart';
part 'get_cost_bloc.freezed.dart';

class GetCostBloc extends Bloc<GetCostEvent, GetCostState> {
  GetCostBloc() : super(const _Initial()) {
    on<_GetCost>(
      (event, emit) async {
        emit(
          const _Loading(),
        );
        final response = await RajaOngkirRemoteDataSource().getCost(
          event.destination,
          event.courier,
          event.origin,
        );

        response.fold(
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
