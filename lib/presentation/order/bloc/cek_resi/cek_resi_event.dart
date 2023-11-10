part of 'cek_resi_bloc.dart';

@freezed
class CekResiEvent with _$CekResiEvent {
  const factory CekResiEvent.started() = _Started;
  const factory CekResiEvent.getCekResi({
    required String courier,
    required String waybill,
  }) = _GetCekResi;
}
