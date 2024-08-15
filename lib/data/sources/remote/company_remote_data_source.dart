import 'package:dartz/dartz.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/data/data.dart';
import 'package:hatofit/domain/domain.dart';

abstract class CompanyRemoteDataSource {
  Future<Either<Failure, CompanyModel>> readCompanyById(
    ByIdParams params,
  );
  Future<Either<Failure, List<CompanyModel>>> readCompanyAll(
    ByLimitParams params,
  );
}

class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  final DioClient _client;

  CompanyRemoteDataSourceImpl(this._client);

  @override
  Future<Either<Failure, CompanyModel>> readCompanyById(
    ByIdParams params,
  ) async {
    final res = await _client.getRequest(
      "${APIConstant.company}/${params.id}",
      converter: (res) => CompanyModel.fromJson(res as Map<String, dynamic>),
    );

    return res;
  }

  @override
  Future<Either<Failure, List<CompanyModel>>> readCompanyAll(
    ByLimitParams params,
  ) async {
    final res = await _client.getRequest(
      APIConstant.company,
      queryParameters: params.toJson(),
      converter: (res) {
        List<CompanyModel> companies = [];
        for (var element in res['companies']) {
          companies.add(CompanyModel.fromJson(element as Map<String, dynamic>));
        }
        return companies;
      },
    );

    return res;
  }
}
