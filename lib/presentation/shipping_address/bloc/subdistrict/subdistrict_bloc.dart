import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/raja_ongkir_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/subdistrict_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subdistrict_event.dart';
part 'subdistrict_state.dart';
part 'subdistrict_bloc.freezed.dart';

class SubdistrictBloc extends Bloc<SubdistrictEvent, SubdistrictState> {
  SubdistrictBloc() : super(const _Initial()) {
    on<_GetSubdistrictByCityId>((event, emit) async {
      emit(
        const _Loading(),
      );
      final result =
          await RajaOngkirRemoteDataSource().getSubdistrict(event.cityId);
      result.fold(
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
