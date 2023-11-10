import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/raja_ongkir_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/city_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_event.dart';
part 'city_state.dart';
part 'city_bloc.freezed.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(const _Initial()) {
    on<_GetAllCyProvinceId>((event, emit) async {
      emit(
        const _Loading(),
      );
      final result =
          await RajaOngkirRemoteDataSource().getCity(event.provinceId);
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
