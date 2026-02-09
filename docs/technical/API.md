# API Documentation

Complete reference for the HatoFit REST API integration.

**Level**: Intermediate  
**Audience**: Backend developers, Mobile developers  
**Last Updated**: February 2026

---

## Table of Contents

1. [Overview](#overview)
2. [Base Configuration](#base-configuration)
3. [Authentication](#authentication)
4. [Error Handling](#error-handling)
5. [Endpoints](#endpoints)
6. [Data Models](#data-models)
7. [Implementation Details](#implementation-details)

---

## Overview

HatoFit uses a RESTful API architecture with the following characteristics:

- **Protocol**: HTTPS
- **Format**: JSON
- **Authentication**: JWT Bearer tokens
- **Versioning**: URL path versioning (`/v1/`)
- **Base URL**: `https://api.hatofit.com/v1/`

### HTTP Methods

| Method | Description |
|--------|-------------|
| `GET` | Retrieve resources |
| `POST` | Create new resources |
| `PUT` | Update existing resources (full replacement) |
| `PATCH` | Partial update of resources |
| `DELETE` | Remove resources |

---

## Base Configuration

### Dio Client Setup

```dart
// lib/data/datasources/remote/api_client.dart

class ApiClient {
  late final Dio _dio;
  
  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.hatofit.com/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add interceptors
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      retries: 3,
    ));
  }
  
  Dio get client => _dio;
}
```

### Authentication Interceptor

```dart
// lib/core/network/auth_interceptor.dart

class AuthInterceptor extends Interceptor {
  final LocalStorageService storage;
  
  AuthInterceptor(this.storage);
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, attempt refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry request with new token
        final token = await storage.getToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $token';
        final response = await _dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      }
    }
    handler.next(err);
  }
}
```

---

## Authentication

### Login

**Endpoint:** `POST /auth/login`

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securepassword123"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "usr_123456",
      "email": "user@example.com",
      "name": "John Doe",
      "avatar": "https://cdn.hatofit.com/avatars/usr_123456.jpg",
      "createdAt": "2025-09-01T10:00:00Z"
    },
    "tokens": {
      "accessToken": "eyJhbGciOiJIUzI1NiIs...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
      "expiresIn": 3600
    }
  }
}
```

### Google Sign-In

**Endpoint:** `POST /auth/google`

**Request:**
```json
{
  "idToken": "google_oauth_id_token",
  "accessToken": "google_oauth_access_token"
}
```

### Register

**Endpoint:** `POST /auth/register`

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securepassword123",
  "name": "John Doe"
}
```

### Logout

**Endpoint:** `POST /auth/logout`

**Headers:**
```
Authorization: Bearer <access_token>
```

---

## Error Handling

### Error Response Format

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": {
      "email": ["Email is required"],
      "password": ["Password must be at least 8 characters"]
    }
  }
}
```

### HTTP Status Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 200 | OK | Request successful |
| 201 | Created | Resource created successfully |
| 400 | Bad Request | Invalid request format |
| 401 | Unauthorized | Missing or invalid token |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource doesn't exist |
| 422 | Validation Error | Invalid input data |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Server Error | Internal server error |

### Error Codes

| Code | Description |
|------|-------------|
| `VALIDATION_ERROR` | Input validation failed |
| `AUTHENTICATION_ERROR` | Invalid credentials |
| `AUTHORIZATION_ERROR` | Insufficient permissions |
| `RESOURCE_NOT_FOUND` | Requested resource not found |
| `RATE_LIMIT_EXCEEDED` | Too many requests |
| `INTERNAL_ERROR` | Server internal error |

---

## Endpoints

### Users

#### Get Current User
```
GET /users/me
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "usr_123456",
    "email": "user@example.com",
    "name": "John Doe",
    "avatar": "https://cdn.hatofit.com/avatars/usr_123456.jpg",
    "metrics": {
      "height": 175,
      "weight": 70,
      "birthDate": "1990-05-15",
      "gender": "male"
    },
    "preferences": {
      "theme": "dark",
      "language": "en",
      "unitSystem": "metric"
    },
    "createdAt": "2025-09-01T10:00:00Z",
    "updatedAt": "2025-09-15T14:30:00Z"
  }
}
```

#### Update User Profile
```
PATCH /users/me
```

**Request:**
```json
{
  "name": "John Updated",
  "metrics": {
    "height": 176,
    "weight": 71
  }
}
```

#### Upload Avatar
```
POST /users/me/avatar
Content-Type: multipart/form-data
```

**Request:**
```
file: <binary_image_data>
```

### Workouts

#### Get Workout History
```
GET /workouts?page=1&limit=20
```

**Response:**
```json
{
  "success": true,
  "data": {
    "workouts": [
      {
        "id": "wkt_789012",
        "name": "Morning Cardio",
        "type": "cardio",
        "duration": 1800,
        "calories": 320,
        "startedAt": "2025-02-08T07:00:00Z",
        "completedAt": "2025-02-08T07:30:00Z",
        "heartRateData": {
          "average": 145,
          "max": 165,
          "min": 85,
          "zones": {
            "warmUp": 180,
            "fatBurn": 600,
            "cardio": 900,
            "peak": 120
          }
        }
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 156,
      "totalPages": 8
    }
  }
}
```

#### Get Workout Details
```
GET /workouts/:id
```

#### Start Workout
```
POST /workouts
```

**Request:**
```json
{
  "name": "Morning Run",
  "type": "running",
  "exercises": ["ex_123", "ex_456"]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "wkt_789012",
    "name": "Morning Run",
    "type": "running",
    "startedAt": "2025-02-09T10:00:00Z",
    "status": "in_progress"
  }
}
```

#### Complete Workout
```
PATCH /workouts/:id/complete
```

**Request:**
```json
{
  "duration": 1800,
  "calories": 320,
  "heartRateData": {
    "average": 145,
    "max": 165,
    "min": 85,
    "readings": [
      {"timestamp": "2025-02-09T10:00:00Z", "value": 85},
      {"timestamp": "2025-02-09T10:01:00Z", "value": 95}
    ]
  }
}
```

### Exercises

#### Get All Exercises
```
GET /exercises?page=1&limit=50&company=comp_123&difficulty=intermediate
```

**Query Parameters:**
- `company`: Filter by fitness company ID
- `difficulty`: beginner, intermediate, advanced
- `category`: cardio, strength, flexibility, etc.

**Response:**
```json
{
  "success": true,
  "data": {
    "exercises": [
      {
        "id": "ex_123456",
        "name": "Push-ups",
        "description": "Classic upper body exercise",
        "difficulty": "intermediate",
        "category": "strength",
        "muscleGroups": ["chest", "shoulders", "triceps"],
        "duration": 60,
        "videoUrl": "https://cdn.hatofit.com/videos/ex_123456.mp4",
        "thumbnail": "https://cdn.hatofit.com/thumbnails/ex_123456.jpg",
        "instructions": [
          "Start in plank position",
          "Lower body until chest nearly touches floor",
          "Push back up to starting position"
        ],
        "company": {
          "id": "comp_123",
          "name": "FitPro Gym"
        }
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 50,
      "total": 245
    }
  }
}
```

#### Get Exercise Details
```
GET /exercises/:id
```

### Companies

#### Get All Companies
```
GET /companies
```

**Response:**
```json
{
  "success": true,
  "data": {
    "companies": [
      {
        "id": "comp_123",
        "name": "FitPro Gym",
        "description": "Premium fitness center with state-of-the-art equipment",
        "logo": "https://cdn.hatofit.com/logos/comp_123.png",
        "location": {
          "address": "123 Fitness Street",
          "city": "Jakarta",
          "country": "Indonesia"
        },
        "exerciseCount": 45,
        "isPartner": true
      }
    ]
  }
}
```

### Devices

#### Get Connected Devices
```
GET /devices
```

**Response:**
```json
{
  "success": true,
  "data": {
    "devices": [
      {
        "id": "dev_456",
        "name": "Polar H10",
        "type": "heart_rate_monitor",
        "brand": "Polar",
        "model": "H10",
        "macAddress": "A4:34:F0:12:34:56",
        "isConnected": true,
        "lastConnectedAt": "2025-02-09T08:00:00Z"
      }
    ]
  }
}
```

#### Register Device
```
POST /devices
```

**Request:**
```json
{
  "name": "Polar H10",
  "type": "heart_rate_monitor",
  "brand": "Polar",
  "model": "H10",
  "macAddress": "A4:34:F0:12:34:56"
}
```

#### Remove Device
```
DELETE /devices/:id
```

---

## Data Models

### User Model

```dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? avatar,
    UserMetrics? metrics,
    UserPreferences? preferences,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserModel;
  
  factory UserModel.fromJson(Map<String, dynamic> json) => 
      _$UserModelFromJson(json);
}

@freezed
class UserMetrics with _$UserMetrics {
  const factory UserMetrics({
    int? height,        // cm
    int? weight,        // kg
    DateTime? birthDate,
    String? gender,     // male, female, other
  }) = _UserMetrics;
  
  factory UserMetrics.fromJson(Map<String, dynamic> json) => 
      _$UserMetricsFromJson(json);
}
```

### Workout Model

```dart
@freezed
class WorkoutModel with _$WorkoutModel {
  const factory WorkoutModel({
    required String id,
    required String name,
    required String type,
    int? duration,          // seconds
    int? calories,
    required DateTime startedAt,
    DateTime? completedAt,
    String? status,         // in_progress, completed, cancelled
    HeartRateData? heartRateData,
    List<ExerciseSession>? exercises,
  }) = _WorkoutModel;
  
  factory WorkoutModel.fromJson(Map<String, dynamic> json) => 
      _$WorkoutModelFromJson(json);
}

@freezed
class HeartRateData with _$HeartRateData {
  const factory HeartRateData({
    int? average,
    int? max,
    int? min,
    HeartRateZones? zones,
    List<HeartRateReading>? readings,
  }) = _HeartRateData;
  
  factory HeartRateData.fromJson(Map<String, dynamic> json) => 
      _$HeartRateDataFromJson(json);
}

@freezed
class HeartRateReading with _$HeartRateReading {
  const factory HeartRateReading({
    required DateTime timestamp,
    required int value,
  }) = _HeartRateReading;
  
  factory HeartRateReading.fromJson(Map<String, dynamic> json) => 
      _$HeartRateReadingFromJson(json);
}
```

### Exercise Model

```dart
@freezed
class ExerciseModel with _$ExerciseModel {
  const factory ExerciseModel({
    required String id,
    required String name,
    required String description,
    required String difficulty,
    required String category,
    List<String>? muscleGroups,
    int? duration,
    String? videoUrl,
    String? thumbnail,
    List<String>? instructions,
    CompanyModel? company,
  }) = _ExerciseModel;
  
  factory ExerciseModel.fromJson(Map<String, dynamic> json) => 
      _$ExerciseModelFromJson(json);
}
```

---

## Implementation Details

### Repository Implementation

```dart
// lib/data/repositories/workout_repository_impl.dart

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDataSource remoteDataSource;
  final WorkoutLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  
  WorkoutRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );
  
  @override
  Future<Either<Failure, List<WorkoutEntity>>> getWorkoutHistory({
    int page = 1,
    int limit = 20,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final workouts = await remoteDataSource.getWorkoutHistory(
          page: page,
          limit: limit,
        );
        
        // Cache the data
        await localDataSource.cacheWorkouts(workouts);
        
        return Right(workouts.map((w) => w.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      // Return cached data if offline
      try {
        final workouts = await localDataSource.getCachedWorkouts();
        return Right(workouts.map((w) => w.toEntity()).toList());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
```

### Use Case Implementation

```dart
// lib/domain/usecases/get_workout_history.dart

class GetWorkoutHistoryUseCase
    implements UseCase<List<WorkoutEntity>, PaginationParams> {
  final WorkoutRepository repository;
  
  GetWorkoutHistoryUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<WorkoutEntity>>> call(
    PaginationParams params,
  ) async {
    return await repository.getWorkoutHistory(
      page: params.page,
      limit: params.limit,
    );
  }
}

class PaginationParams {
  final int page;
  final int limit;
  
  PaginationParams({this.page = 1, this.limit = 20});
}
```

---

## Rate Limiting

The API implements rate limiting to ensure fair usage:

| Endpoint Type | Limit | Window |
|---------------|-------|--------|
| Authentication | 10 requests | 1 minute |
| Standard API | 100 requests | 1 minute |
| Workout upload | 60 requests | 1 minute |

**Rate Limit Headers:**
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1644312000
```

---

## API Versioning

Current version: **v1**

Future versions will be available at:
- `/v2/` (planned for Q3 2026)
- `/v1/` (current, supported until Q1 2027)

Version deprecation notice will be sent 6 months in advance.

---

## Testing

### API Client Tests

```dart
// test/data/datasources/remote/api_client_test.dart

void main() {
  late ApiClient apiClient;
  late MockDio mockDio;
  
  setUp(() {
    mockDio = MockDio();
    apiClient = ApiClient(dio: mockDio);
  });
  
  group('getWorkoutHistory', () {
    test('should return list of workouts on success', () async {
      // Arrange
      final response = Response(
        data: {
          'success': true,
          'data': {
            'workouts': [/* ... */]
          }
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: '/workouts'),
      );
      when(mockDio.get('/workouts', queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => response);
      
      // Act
      final result = await apiClient.getWorkoutHistory();
      
      // Assert
      expect(result, isA<List<WorkoutModel>>());
    });
  });
}
```

---

## Related Documentation

- [Architecture Overview](ARCHITECTURE.md) - System design
- [Database Guide](DATABASE.md) - Local storage
- [State Management](STATE_MANAGEMENT.md) - BLoC patterns
- [Glossary](../meta/GLOSSARY.md) - Terminology

---

**Questions?** Contact the backend team or check the API changelog.