import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/raja_ongkir_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/province_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'province_event.dart';
part 'province_state.dart';
part 'province_bloc.freezed.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(
        const _Loading(),
      );
      final response = await RajaOngkirRemoteDataSource().getProvince();

      response.fold(
        (l) => emit(
          _Error(l),
        ),
        (r) => emit(
          _Loaded(r.rajaongkir.results),
        ),
      );
    });
  }
}
