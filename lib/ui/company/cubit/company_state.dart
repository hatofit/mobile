part of 'company_cubit.dart';

@freezed
class CompanyState with _$CompanyState {
  const factory CompanyState.loading() = _Loading;
  const factory CompanyState.success(List<CompanyEntity> companies) = _Success;
  const factory CompanyState.failure(Failure message) = _Failure;
}
