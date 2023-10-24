import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/requests/register_requests_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/auth_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());

      final response = await AuthRemoteDataSource().register(event.data);

      response.fold(
        (l) => emit(
          _Error(l),
        ),
        (r) => emit(
          _Success(r),
        ),
      );
    });
  }
}
