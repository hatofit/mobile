import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

typedef JSONIConv<T> = T Function(dynamic response);

class DioClient with FirebaseCrashLogger {
  String? _auth;
  late Dio _dio;
  final BoxClient _boxClient;
  RetryInterceptor retryInterceptor() {
    return RetryInterceptor(
      dio: _dio,
      logPrint: log.e,
      retries: 2,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 2),
        Duration(seconds: 1),
      ],
    );
  }

  DioClient(this._boxClient) {
    try {
      _auth = _boxClient.userBox.get(UserBoxKeys.token.name);
      _dio = _createDio();
      _dio.interceptors.add(DioInterceptor());
      _dio.interceptors.add(retryInterceptor());
    } catch (error, stackTrace) {
      nonFatalError(error: error, stackTrace: stackTrace);
    }
  }

  Dio get dio {
    try {
      _auth = _boxClient.userBox.get(UserBoxKeys.token.name);
      _dio = _createDio();
      _dio.interceptors.add(DioInterceptor());
      _dio.interceptors.add(retryInterceptor());
    } catch (error, stackTrace) {
      nonFatalError(error: error, stackTrace: stackTrace);
    }
    return _dio;
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: APIConstant.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (_auth != null) ...{
              'Authorization': "Bearer $_auth",
            },
          },
          receiveTimeout: const Duration(minutes: 1),
          connectTimeout: const Duration(minutes: 1),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required JSONIConv<T> converter,
    ProgressCallback? onReceiveProgress,
    bool withoutAutoRetry = false,
  }) async {
    try {
      if (withoutAutoRetry) {
        _dio.interceptors.removeWhere((element) => element is RetryInterceptor);
      } else {
        if (!_dio.interceptors.any((element) => element is RetryInterceptor)) {
          _dio.interceptors.add(retryInterceptor());
        }
      }
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      final isolateParse = JSONIParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();

      return Right(result);
    } on DioException catch (e, stackTrace) {
      return handleException(e, stackTrace);
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    FormData? formData,
    JSONIConv<T>? converter,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: data ?? formData,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      if (converter == null) {
        return Right(response.data as T);
      } else {
        final isolateParse = JSONIParser<T>(
          response.data as Map<String, dynamic>,
          converter,
        );
        final result = await isolateParse.parseInBackground();
        return Right(result);
      }
    } on DioException catch (e, stackTrace) {
      return handleException(e, stackTrace);
    }
  }

  Future<Either<Failure, T>> putRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    FormData? formData,
    JSONIConv<T>? converter,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await dio.put(
        url,
        data: data ?? formData,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (converter == null) {
        return Right(response.data as T);
      } else {
        final isolateParse = JSONIParser<T>(
          response.data as Map<String, dynamic>,
          converter,
        );
        final result = await isolateParse.parseInBackground();
        return Right(result);
      }
    } on DioException catch (e, stackTrace) {
      return handleException(e, stackTrace);
    }
  }

  Future<Either<Failure, T>> deleteRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    JSONIConv<T>? converter,
  }) async {
    try {
      final response = await dio.delete(
        url,
        data: data,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      if (converter == null) {
        return Right(response.data as T);
      } else {
        final isolateParse = JSONIParser<T>(
          response.data as Map<String, dynamic>,
          converter,
        );
        final result = await isolateParse.parseInBackground();
        return Right(result);
      }
    } on DioException catch (e, stackTrace) {
      return handleException(e, stackTrace);
    }
  }

  Future<Either<Failure, File>> downloadRequest(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final defaultPath = (await getExternalStorageDirectory())?.path;
      final response = await Dio().download(
        url,
        "$defaultPath/$savePath",
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return Right(File(savePath));
    } on DioException catch (e, stackTrace) {
      return handleException(e, stackTrace);
    }
  }

  FutureOr<Either<Failure, T>> handleException<T>(
    DioException e,
    StackTrace stackTrace,
  ) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return const Left(ServerFailure());
    }

    // known errors
    final code = e.response?.statusCode;
    if (code == 204) {
      return const Left(NoContentFailure());
    }
    if (code == 400) {
      return const Left(BadRequestFailure());
    }
    if (code == 401) {
      return const Left(UnauthorizedFailure());
    }
    if (code == 404) {
      return const Left(NotFoundFailure());
    }
    if (code == 408) {
      return const Left(ConnectionTimeoutFailure());
    }
    if (code == 403) {
      return const Left(ForbiddenFailure());
    }

    if (e.response?.data is String) {
      return const Left(ServerFailure());
    }

    final res = e.response?.data as Map<String, dynamic>?;
    if (res == null) {
      return const Left(
        ServerFailure(),
      );
    }
    nonFatalError(error: e, stackTrace: stackTrace);
    return Left(
      ServerFailure(
        message: e.response == null
            ? e.message ??
                "Something went wrong on the server's end, and it couldn't complete your request"
            : res['message'] as String? ??
                "Something went wrong on the server's end, and it couldn't complete your request",
      ),
    );
  }
}
