import 'package:dartz/dartz.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';

class CompanyAllUsecase extends FPUC<List<CompanyEntity>, ByLimitParams> {
  final CompanyRepo _repo;

  CompanyAllUsecase(this._repo);

  @override
  Future<Either<Failure, List<CompanyEntity>>> call(ByLimitParams params) =>
      _repo.readCompanyAll(params);
}
