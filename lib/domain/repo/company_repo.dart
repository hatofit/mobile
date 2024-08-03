import 'package:dartz/dartz.dart';
import 'package:hatofit/core/error/failure.dart';
import 'package:hatofit/domain/domain.dart';

abstract class CompanyRepo {
  Future<Either<Failure, CompanyEntity>> readCompanyById(
    ByIdParams params,
  );
  Future<Either<Failure, List<CompanyEntity>>> readCompanyAll(
    ByLimitParams params,
  );
}
