import 'package:dartz/dartz.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';

class CompanyByIdUsecase extends FPUC<CompanyEntity, ByIdParams> {
  final CompanyRepo _repo;

  CompanyByIdUsecase(this._repo);

  @override
  Future<Either<Failure, CompanyEntity>> call(ByIdParams params) =>
      _repo.readCompanyById(params);
}
