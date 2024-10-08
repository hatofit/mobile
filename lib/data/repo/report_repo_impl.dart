import 'package:dartz/dartz.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/data/data.dart';
import 'package:hatofit/domain/domain.dart';

class ReportRepoImpl implements ReportRepo {
  final ReportRemoteDataSource _remote;
  final ReportLocalDataSource _local;

  const ReportRepoImpl(
    this._remote,
    this._local,
  );

  @override
  Future<Either<Failure, ReportEntity>> readReportById(
    ByIdParams params,
  ) async {
    final res = await _remote.readReportById(params);
    return res.fold(
      (failure) async {
        return await _local.readReportById(params);
      },
      (reportModel) async {
        final entity = reportModel.toEntity();
        await _local.cacheReport(entity);
        return Right(entity);
      },
    );
  }

  @override
  Future<Either<Failure, List<ReportEntity>>> readReportAll(
    ByLimitParams params,
  ) async {
    final res = await _remote.readReportAll(params);
    return res.fold(
      (failure) async {
        return await _local.readReportAll();
      },
      (reportModels) async {
        final parser = IParser<List<ReportEntity>>(
          reportModels,
          (res) {
            return res.map((e) => e.toEntity()).toList();
          },
        );
        final res = await parser.parseInBackground();
        for (var e in res) {
          await _local.cacheReport(e);
        }
        return Right(res);
      },
    );
  }
}
