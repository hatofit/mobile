part of 'activity_cubit.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState.loading() = _Loading;
  const factory ActivityState.success({
    @Default([]) List<SessionEntity> session,
    ReportEntity? report,
  }) = _Success;
  const factory ActivityState.failure(Failure message) = _Failure;
}
