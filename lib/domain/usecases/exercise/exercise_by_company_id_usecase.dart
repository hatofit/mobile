import 'package:dartz/dartz.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';

class ExerciseByCompanyIdUsecase
    extends FPUC<List<ExerciseEntity>, ByIdParams> {
  final ExerciseRepo _repo;

  ExerciseByCompanyIdUsecase(this._repo);

  @override
  Future<Either<Failure, List<ExerciseEntity>>> call(ByIdParams params) =>
      _repo.readExerciseByCompanyId(params);
}
