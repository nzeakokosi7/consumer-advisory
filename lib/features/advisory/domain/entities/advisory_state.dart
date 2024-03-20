import 'package:freezed_annotation/freezed_annotation.dart';

part "advisory_state.freezed.dart";

@freezed
class AdvisoryState with _$AdvisoryState {
  const factory AdvisoryState.initial() = _Initial;

  const factory AdvisoryState.postInitial() = _PostInitial;

  const factory AdvisoryState.uploading({required String title}) = _Uploading;

  const factory AdvisoryState.deleting() = _Deleting;

  const factory AdvisoryState.extractText({required String state}) =
      _ExtractText;

  const factory AdvisoryState.sendPrompt({required String state}) = _SendPrompt;

  const factory AdvisoryState.error({required String errorMessage}) = _Error;

  const factory AdvisoryState.finalized({required String productTitle}) =
      _Finalized;
}
