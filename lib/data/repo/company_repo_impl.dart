import 'package:dartz/dartz.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/data/data.dart';
import 'package:hatofit/domain/domain.dart';

class CompanyRepoImpl implements CompanyRepo {
  final CompanyRemoteDataSource _remote;
  final CompanyLocalDataSource _local;

  const CompanyRepoImpl(
    this._remote,
    this._local,
  );

  @override
  Future<Either<Failure, List<CompanyEntity>>> readCompanyAll(
    ByLimitParams params,
  ) async {
    final res = await _remote.readCompanyAll(params);
    return res.fold(
      (failure) async {
        return await _local.readCompanyAll();
      },
      (companyModels) async {
        final parser = IParser<List<CompanyEntity>>(
          companyModels,
          (res) {
            final List<CompanyModel> resM = res.cast<CompanyModel>();
            final List<CompanyEntity> resE =
                resM.map((e) => e.toEntity()).toList();
            return resE;
          },
        );
        final res = await parser.parseInBackground();
        for (final e in res) {
          await _local.cacheCompany(e);
        }
        return Right(res);
      },
    );
  }

  @override
  Future<Either<Failure, CompanyEntity>> readCompanyById(
    ByIdParams params,
  ) async {
    final res = await _remote.readCompanyById(params);
    return res.fold(
      (failure) async {
        return await _local.readCompanyById(params);
      },
      (companyModel) {
        return Right(companyModel.toEntity());
      },
    );
  }
}
