import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';
import 'package:hatofit/utils/utils.dart';
import 'package:intl/intl.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final MeUseCase _meUseCase;
  final ReqBLEPermUsecase _reqBLEPermUsecase;
  final ReadUserUsecase _readUserUsecase;
  final ReadTokenUsecase _readTokenUsecase;
  final ReadMoodUsecase _getMoodUsecase;
  final DeleteMoodUsecase _clearMoodUsecase;
  final UpdateOfflineModeUsecase _updateOfflineModeUsecase;

  SplashCubit(
    this._meUseCase,
    this._reqBLEPermUsecase,
    this._readUserUsecase,
    this._readTokenUsecase,
    this._getMoodUsecase,
    this._clearMoodUsecase,
    this._updateOfflineModeUsecase,
  ) : super(const _Initial());

  Future<void> init() async {
    log.e("STATE SPLASH CUBIT: ${state}");
    await fetchUser();
    await requestPermissions();
    checkAuth();
    checkMood();
    log.e("STATE SPLASH CUBIT: ${state}");
  }

  Future<void> requestPermissions() async {
    await _reqBLEPermUsecase.call();
  }

  void checkAuth() {
    final token = _readTokenUsecase.call();
    log.e("TOKEN: ${token}");
    token.fold(
      (l) {
        safeEmit(
          _Unauthorized("Unauthorized"),
          isClosed: isClosed,
          emit: emit,
        );
      },
      (r) async {
        final res = await _meUseCase.call();
        res.fold(
          (l) async {
            log.e(l);
            if (l is ServerFailure) {
              safeEmit(
                _Unauthorized(l.message ?? "Unauthorized"),
                isClosed: isClosed,
                emit: emit,
              );
            }
            if (l is ConnectionTimeoutFailure) {
              safeEmit(
                _Unauthorized(l.message ?? "Unauthorized"),
                isClosed: isClosed,
                emit: emit,
              );
            }
          },
          (r) {
            safeEmit(
              const _Authorized("Authorized"),
              isClosed: isClosed,
              emit: emit,
            );
          },
        );
      },
    );
  }

  bool _isInitialized = false;
  UserEntity? _user;

  bool get isInitialized => _isInitialized;
  UserEntity? get user => _user;

  void checkMood() {
    final res = _getMoodUsecase.call();
    res.fold((l) async => await _clearMoodUsecase.call(), (r) {
      if (r.isNotEmpty) {
        final date = DateFormat('d MMMM yyyy').format(DateTime.now());
        if (r != date) {
          _clearMoodUsecase.call();
        }
      }
    });
  }

  Future<UserEntity?> fetchUser() async {
    final res =
        await _readUserUsecase.call(const ByLimitParams(showFromLocal: true));
    return res.fold((l) {
      _isInitialized = false;
      _user = null;
      return null;
    }, (r) {
      _isInitialized = true;
      _user = r;
      return r;
    });
  }

  Future<void> upsertOfflineMode(bool value) async {
    await _updateOfflineModeUsecase.call(value);
  }
}
