import 'package:dartz/dartz.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';

class FirebaseRemoteConfigRepoImpl implements FirebaseRemoteConfigRepo {
  final RemoteConfig _remote;
  final BoxClient _local;
  FirebaseRemoteConfigRepoImpl(
    this._remote,
    this._local,
  );

  @override
  Future<Either<Failure, String>> getString(String key) async {
    final res = await _remote.getString(key);
    return res.fold((l) {
      return Left(l);
    }, (r) async {
      await _local.appConfigBox.put(key, r);
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, bool>> getBool(String key) async {
    final res = await _remote.getBool(key);
    return res.fold((l) {
      return Left(l);
    }, (r) async {
      await _local.appConfigBox.put(key, r);
      return Right(r);
    });
  }
}
