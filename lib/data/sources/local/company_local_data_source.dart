import 'package:dartz/dartz.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';
import 'package:hatofit/utils/services/firebase/firebase.dart';

abstract class CompanyLocalDataSource {
  Future<Either<Failure, CompanyEntity>> cacheCompany(
    CompanyEntity entity,
  );
  Future<Either<Failure, CompanyEntity>> readCompanyById(
    ByIdParams params,
  );
  Future<Either<Failure, List<CompanyEntity>>> readCompanyAll();
}

class CompanyLocalDataSourceImpl
    with FirebaseCrashLogger
    implements CompanyLocalDataSource {
  final BoxClient _box;

  CompanyLocalDataSourceImpl(
    this._box,
  );

  @override
  Future<Either<Failure, CompanyEntity>> cacheCompany(
    CompanyEntity entity,
  ) async {
    try {
      final all = _box.companyBox.toMap();
      int key = 0;

      if (all.isEmpty) {
        key = await _box.companyBox.add(entity);
      } else {
        for (var element in all.entries) {
          if (element.value.id == entity.id) {
            await _box.companyBox.put(element.key, entity);
            key = element.key;
            break;
          } else {
            key = await _box.companyBox.add(entity);
            break;
          }
        }
      }

      final res = _box.companyBox.get(key);
      if (res == null) {
        return const Left(CacheFailure("Failed to cache company"));
      }

      return Right(res);
    } catch (e, s) {
      nonFatalError(error: e, stackTrace: s);
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CompanyEntity>> readCompanyById(
    ByIdParams params,
  ) async {
    try {
      final all = _box.companyBox.toMap();
      CompanyEntity? found;

      for (var element in all.entries) {
        if (element.value.id == int.parse(params.id)) {
          found = element.value;
          break;
        }
      }

      if (found == null) {
        return const Left(CacheFailure("Failed to read company"));
      }

      return Right(found);
    } catch (e, s) {
      nonFatalError(error: e, stackTrace: s);
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CompanyEntity>>> readCompanyAll() async {
    try {
      final res = _box.companyBox.values.toList();

      if (res.isEmpty) {
        return const Left(CacheFailure("Failed to read company"));
      }

      return Right(res);
    } catch (e, s) {
      nonFatalError(error: e, stackTrace: s);
      return Left(CacheFailure(e.toString()));
    }
  }
}
