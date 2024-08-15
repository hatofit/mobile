import 'package:hatofit/core/core.dart';

// 204 No Content
class NoContentFailure extends Failure {
  final String? title;
  final String? message;

  const NoContentFailure({
    this.title = "No Content",
    this.message = "The server didn't send any information back.",
  });

  @override
  bool operator ==(Object other) => other is NoContentFailure;

  @override
  int get hashCode => 0;
}

// 400 Bad Request
class BadRequestFailure extends Failure {
  final String? title;
  final String? message;

  const BadRequestFailure({
    this.title = "Bad Request",
    this.message =
        "The request could not be understood by the server due to malformed syntax",
  });

  @override
  bool operator ==(Object other) =>
      other is BadRequestFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

// 401 Unauthorized
class UnauthorizedFailure extends Failure {
  final String? title;
  final String? message;

  const UnauthorizedFailure({
    this.title = "Unauthorized",
    this.message = "You don't have permission to access this resource.",
  });

  @override
  bool operator ==(Object other) =>
      other is UnauthorizedFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

// 403 Forbidden
class ForbiddenFailure extends Failure {
  final String? title;
  final String? message;

  const ForbiddenFailure({
    this.title = "Forbidden",
    this.message = "You don't have permission to access this resource",
  });

  @override
  bool operator ==(Object other) =>
      other is ForbiddenFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

// 404 Not Found
class NotFoundFailure extends Failure {
  final String? title;
  final String? message;

  const NotFoundFailure({
    this.title = "Not Found",
    this.message =
        "The requested item or page couldn't be found on the server.",
  });

  @override
  bool operator ==(Object other) =>
      other is NotFoundFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

// 408 Request Timeout
class ConnectionTimeoutFailure extends Failure {
  final String? title;
  final String? message;

  const ConnectionTimeoutFailure({
    this.title = "Connection Timeout",
    this.message =
        "Server is taking too long to respond. Please try again later.",
  });

  @override
  bool operator ==(Object other) =>
      other is ConnectionTimeoutFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

// 500 Internal Server Error
class ServerFailure extends Failure {
  final String? title;
  final String? message;

  const ServerFailure({
    this.title = "Internal Server Error",
    this.message =
        "Something went wrong on the server's end, and it couldn't complete your request.",
  });

  @override
  bool operator ==(Object other) =>
      other is ServerFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}
