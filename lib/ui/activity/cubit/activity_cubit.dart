import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';
import 'package:hatofit/utils/helper/helper.dart';

part 'activity_cubit.freezed.dart';
part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final SessionAllUsecase _getSessionsUsecase;
  final ReportByIdUsecase _getReportByIdUsecase;

  ActivityCubit(
    this._getSessionsUsecase,
    this._getReportByIdUsecase,
  ) : super(const _Loading());

  Future<void> init() async {
    await getSessions();
  }

  Future<void> getSessions() async {
    emit(const _Loading());
    final res = await _getSessionsUsecase.call(const ByLimitParams());
    res.fold(
      (failure) => emit(_Failure(failure)),
      (session) {
        emit(_Success(session: session));
      },
    );
  }

  Future<void> getReportById(String id) async {
    emit(const _Loading());
    final res = await _getReportByIdUsecase.call(ByIdParams(id: id));
    log.d('Get report by id: $res');
    res.fold(
      (failure) => emit(_Failure(failure)),
      (report) {
        ReportEntity? nullable;
        nullable = report;
        emit(_Success(report: nullable));
      },
    );
  }
}
