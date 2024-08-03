import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';

part 'company_cubit.freezed.dart';
part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  final CompanyAllUsecase _companyAllUsecase;

  CompanyCubit(
    this._companyAllUsecase,
  ) : super(const _Loading());

  Future<void> init() async {
    await getCompanies();
  }

  Future<void> getCompanies() async {
    emit(const _Loading());
    final result = await _companyAllUsecase.call(const ByLimitParams());
    result.fold(
      (failure) => emit(_Failure(failure)),
      (companies) => emit(_Success(companies)),
    );
  }
}
