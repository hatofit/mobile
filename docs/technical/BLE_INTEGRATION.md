# HatoFit BLE Integration Documentation

## Overview

HatoFit integrates with Bluetooth Low Energy (BLE) devices to capture real-time fitness data including heart rate, ECG, accelerometer, gyroscope, magnetometer, and PPG (Photoplethysmography). The app supports both **Polar SDK** for Polar devices and **Flutter Blue Plus** for generic BLE devices.

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Supported Devices](#supported-devices)
3. [Permissions](#permissions)
4. [Polar SDK Integration](#polar-sdk-integration)
5. [Flutter Blue Plus Integration](#flutter-blue-plus-integration)
6. [Data Streams](#data-streams)
7. [Connection Management](#connection-management)
8. [Use Cases](#use-cases)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

---

## Architecture Overview

### BLE Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                           UI Layer                               │
│              (Device Discovery, Connection UI)                   │
├─────────────────────────────────────────────────────────────────┤
│                      NavigationCubit                             │
│              (Manages BLE state and navigation)                  │
├─────────────────────────────────────────────────────────────────┤
│                       Use Cases                                  │
│    (Connect, Disconnect, Stream Data, Scan Devices)              │
├─────────────────────────────────────────────────────────────────┤
│                     Repository Layer                             │
│      (PolarBLERepo, CommonBLERepo - Abstraction)                 │
├─────────────────────────────────────────────────────────────────┤
│                    Client Layer                                  │
│         (PolarClient, CommonClient - SDK Wrappers)               │
├─────────────────────────────────────────────────────────────────┤
│                      SDK Layer                                   │
│         (polar: ^7.5.1, flutter_blue_plus: ^1.35.2)              │
├─────────────────────────────────────────────────────────────────┤
│                    Device Layer                                  │
│            (Polar H10, H9, Verity Sense, etc.)                   │
└─────────────────────────────────────────────────────────────────┘
```

### Key Components

| Component | Type | Purpose | Location |
|-----------|------|---------|----------|
| `PolarClient` | Client | Polar SDK wrapper | `core/sources/ble/polar_client.dart` |
| `CommonClient` | Client | Generic BLE wrapper | `core/sources/ble/common_client.dart` |
| `PolarBLERepo` | Repository | Polar device abstraction | `data/repo/ble/polar_ble_repo_impl.dart` |
| `CommonBLERepo` | Repository | Generic BLE abstraction | `data/repo/ble/common_ble_repo_impl.dart` |
| `NavigationCubit` | State Management | BLE state management | `ui/navigation/cubit/navigation_cubit.dart` |

---

## Supported Devices

### Polar Devices (via Polar SDK)

| Device | Heart Rate | ECG | Accelerometer | Gyroscope | Magnetometer | PPG |
|--------|------------|-----|---------------|-----------|--------------|-----|
| H10 | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| H9 | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Verity Sense | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ |
| OH1 | ✅ | ❌ | ✅ | ❌ | ❌ | ✅ |

### Generic BLE Devices (via Flutter Blue Plus)

Any BLE device implementing standard GATT services:
- Heart Rate Service (0x180D)
- Battery Service (0x180F)
- Device Information Service (0x180A)

---

## Permissions

### Android Configuration

```xml
<!-- AndroidManifest.xml -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<!-- For Android 12+ -->
<uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
```

### iOS Configuration

```xml
<!-- Info.plist -->
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app uses Bluetooth to connect to heart rate monitors</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app uses Bluetooth to connect to heart rate monitors</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app uses location to scan for BLE devices</string>
```

### Runtime Permission Request

```dart
// lib/domain/usecases/ble/req_ble_perm_usecase.dart
class ReqBLEPermUsecase extends UseCase<Future<bool>, void> {
  final CommonBLERepo _repo;
  
  @override
  Future<bool> call(void params) async {
    final permissions = await _repo.requestPermissions();
    return permissions.values.every((status) => status.isGranted);
  }
}
```

---

## Polar SDK Integration

### Initialization

```dart
// lib/core/sources/ble/polar_client.dart
class PolarClient {
  final Polar _polar = Polar();
  
  Future<Either<Failure, void>> connectToDevice({
    required String deviceId,
  }) async {
    try {
      await _polar.connectToDevice(deviceId);
      return const Right(null);
    } catch (e, stackTrace) {
      nonFatalError(error: e, stackTrace: stackTrace);
      return Left(BLEFailure(e.toString()));
    }
  }
}
```

### Heart Rate Streaming

```dart
Stream<Either<Failure, PolarStreamingData<PolarHrSample>>> polarHrStream(
  String deviceId,
  Set<PolarDataType> types,
) async* {
  try {
    await for (final data in _polar.startStreaming(
      deviceId,
      PolarDataType.hr,
    )) {
      yield Right(PolarStreamingData(data as PolarHrSample, types));
    }
  } catch (e, stackTrace) {
    nonFatalError(error: e, stackTrace: stackTrace);
    yield Left(BLEFailure(e.toString()));
  }
}
```

### ECG Streaming

```dart
Stream<Either<Failure, PolarStreamingData<PolarEcgSample>>> polarEcgStream(
  String deviceId,
  Set<PolarDataType> types,
) async* {
  try {
    await for (final data in _polar.startStreaming(
      deviceId,
      PolarDataType.ecg,
    )) {
      yield Right(PolarStreamingData(
        (data as List<PolarEcgSample>).first,
        types,
      ));
    }
  } catch (e, stackTrace) {
    nonFatalError(error: e, stackTrace: stackTrace);
    yield Left(BLEFailure(e.toString()));
  }
}
```

### Repository Implementation

```dart
// lib/data/repo/ble/polar_ble_repo_impl.dart
class PolarBLERepoImpl implements PolarBLERepo {
  final PolarClient _client;
  
  PolarBLERepoImpl(this._client);
  
  @override
  Future<Either<Failure, void>> connectToDevice(
    ConnectPolarParams params,
  ) async => await _client.connectToDevice(deviceId: params.deviceId);
  
  @override
  Stream<Either<Failure, PolarStreamingData<PolarHrSample>>> streamHr(
    StreamPolarParams params,
  ) async* {
    await for (final data in _client.polarHrStream(params.deviceId, params.types)) {
      yield data;
    }
  }
  
  // ... other stream methods
}
```

---

## Flutter Blue Plus Integration

### Scanning for Devices

```dart
// lib/core/sources/ble/common_client.dart
class CommonClient {
  Stream<List<ScanResult>> scanDevices() {
    return FlutterBluePlus.scanResults;
  }
  
  Future<void> startScan() async {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 30),
      androidUsesFineLocation: true,
    );
  }
  
  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }
}
```

### Connecting to Generic BLE Devices

```dart
Future<Either<Failure, void>> connectToDevice(BluetoothDevice device) async {
  try {
    await device.connect(
      autoConnect: false,
      mtu: null,
    );
    return const Right(null);
  } catch (e, stackTrace) {
    nonFatalError(error: e, stackTrace: stackTrace);
    return Left(BLEFailure(e.toString()));
  }
}
```

### Reading Characteristics

```dart
Future<Either<Failure, List<int>>> readCharacteristic(
  BluetoothCharacteristic characteristic,
) async {
  try {
    final value = await characteristic.read();
    return Right(value);
  } catch (e, stackTrace) {
    nonFatalError(error: e, stackTrace: stackTrace);
    return Left(BLEFailure(e.toString()));
  }
}
```

---

## Data Streams

### Available Data Types

```dart
// lib/domain/entities/ble/ble_entity.dart
enum PolarDataType {
  hr,           // Heart Rate
  ecg,          // Electrocardiogram
  acc,          // Accelerometer
  gyro,         // Gyroscope
  magnetometer, // Magnetometer
  ppg,          // Photoplethysmography
}
```

### Stream Architecture

```dart
// In NavigationCubit - managing all streams
Map<PolarDataType, StreamSubscription> subs = {};

void startStreaming(String deviceId, Set<PolarDataType> types) {
  // Heart Rate
  if (types.contains(PolarDataType.hr)) {
    subs[PolarDataType.hr] = _streamHrPolarBLEUsecase
      .call(StreamPolarParams(deviceId: deviceId, types: types))
      .listen((either) {
        either.fold(
          (failure) => handleError(failure),
          (data) => processHrData(data),
        );
      });
  }
  
  // ECG
  if (types.contains(PolarDataType.ecg)) {
    subs[PolarDataType.ecg] = _streamEcgPolarBLEUsecase
      .call(StreamPolarParams(deviceId: deviceId, types: types))
      .listen((either) {
        either.fold(
          (failure) => handleError(failure),
          (data) => processEcgData(data),
        );
      });
  }
  
  // ... other streams
}
```

### Data Processing Pipeline

```
Device → SDK Stream → Repository → Use Case → Cubit → Parser → UI
  │         │            │           │        │       │      │
  ▼         ▼            ▼           ▼        ▼       ▼      ▼
Raw    PolarHrSample  Either    Stream   State   IParser  Widgets
Data   List<int>      <Failure,          Update  (Isolate Rebuild
       Map             PolarData>         
```

---

## Connection Management

### Connection States

```dart
// lib/ui/navigation/cubit/navigation_cubit.dart
enum DeviceConnectionState {
  disconnected,
  scanning,
  connecting,
  connected,
  streaming,
  error,
}

class BleEntity {
  final String? deviceId;
  final String? deviceName;
  final DeviceConnectionState connectionState;
  final Set<PolarDataType> availableTypes;
}
```

### Lifecycle Management

```dart
class NavigationCubit extends Cubit<NavigationState> {
  StreamSubscription? _connectionStateSub;
  
  void init() async {
    // Listen to connection state changes
    _connectionStateSub = _statePolarBleUsecase.call(NoParams()).listen(
      (either) {
        either.fold(
          (failure) => emit(state.copyWith(error: failure.message)),
          (connectionState) {
            ble = ble.copyWith(connectionState: connectionState);
            emit(_Ble(bluetoothDevice: ble));
          },
        );
      },
    );
  }
  
  void connectToPolar(ConnectPolarParams params) async {
    emit(const _Loading());
    final result = await _connectPolarBLEUsecase.call(params);
    result.fold(
      (failure) => emit(_Failure(failure)),
      (_) {
        ble = ble.copyWith(deviceId: params.deviceId);
        startStreaming(params.deviceId, params.types);
      },
    );
  }
  
  @override
  Future<void> close() {
    // Clean up all subscriptions
    subs.forEach((_, sub) => sub?.cancel());
    _connectionStateSub?.cancel();
    return super.close();
  }
}
```

---

## Use Cases

### Polar BLE Use Cases

```dart
// lib/domain/usecases/ble/polar/

// Connection
ConnectPolarBLEUsecase      // Connect to Polar device
DisconnectPolarBLEUsecase   // Disconnect from device
StatePolarBleUsecase        // Monitor connection state

// Streaming
StreamHrPolarBLEUsecase           // Heart rate data
StreamEcgPolarBLEUsecase          // ECG data
StreamAccPolarBLEUsecase          // Accelerometer data
StreamGyroPolarBLEUsecase         // Gyroscope data
StreamMagnetometerPolarBLEUsecase // Magnetometer data
StreamPpgPolarBLEUsecase          // PPG data

// Discovery
GetServicesPolarBLEUsecase  // Get available services/features
```

### Common BLE Use Cases

```dart
// lib/domain/usecases/ble/common/

// Permissions
ReqBLEPermUsecase           // Request BLE permissions

// Scanning
ScanCommonBLEUsecase        // Start scanning
StopScanBLEUsecase          // Stop scanning
ScanResultsBLEUsecase       // Get scan results
IsScanningBLEUsecase        // Check scanning status

// Connection
ConnectCommonBLEUsecase     // Connect to device
DisconnectCommonBleUsecase  // Disconnect from device
AdapterStateBLEUsecase      // Check Bluetooth adapter state

// Data
GetServicesCommonBLEUsecase // Discover services
StreamCommonBLEUsecase      // Stream notifications
ReadCommonBLEUsecase        // Read characteristics
```

---

## Best Practices

### 1. Always Check Permissions

```dart
Future<bool> ensurePermissions() async {
  final hasPermissions = await _reqBLEPermUsecase.call(null);
  if (!hasPermissions) {
    // Show permission dialog
    return false;
  }
  return true;
}
```

### 2. Handle Connection Failures Gracefully

```dart
void connectWithRetry(String deviceId, int maxRetries) async {
  int attempts = 0;
  while (attempts < maxRetries) {
    final result = await _connectPolarBLEUsecase.call(
      ConnectPolarParams(deviceId: deviceId),
    );
    result.fold(
      (failure) {
        attempts++;
        if (attempts >= maxRetries) {
          emit(_Failure(failure));
        } else {
          Future.delayed(Duration(seconds: 2 * attempts));
        }
      },
      (_) => emit(_Success()),
    );
  }
}
```

### 3. Dispose Streams Properly

```dart
@override
Future<void> close() {
  // Cancel all stream subscriptions
  subs.forEach((type, subscription) {
    subscription?.cancel();
  });
  subs.clear();
  
  // Disconnect device
  if (ble.deviceId != null) {
    _disconnectPolarBLEUsecase.call(
      DisconnectPolarParams(deviceId: ble.deviceId!),
    );
  }
  
  return super.close();
}
```

### 4. Process Data in Isolates

```dart
// lib/core/sources/http/isolate_parser.dart
class IParser<T> {
  final T data;
  final T Function(T) computation;
  
  Future<T> parseInBackground() async {
    return await compute(_parse, _ParseParams(data, computation));
  }
}

// Usage in WorkoutCubit
Future<void> processWorkoutData() async {
  final parser = IParser(ses, (res) {
    // Heavy calculations: calories, HR zones, averages
    return calculateMetrics(res);
  });
  final result = await parser.parseInBackground();
  emit(_DataUpdated(result));
}
```

### 5. Validate Data Before Processing

```dart
void processHrData(PolarStreamingData<PolarHrSample> data) {
  if (data.data.hr < 30 || data.data.hr > 250) {
    // Invalid HR reading, skip
    return;
  }
  
  // Process valid data
  ses.hrSamples?.add(HrSample(
    timeStamp: DateTime.now(),
    hr: data.data.hr,
    rrsMs: data.data.rrsMs,
  ));
}
```

---

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `Scan fails silently` | Missing location permission | Grant location permission |
| `Connection timeout` | Device out of range | Move closer to device |
| `HR data stops` | Skin contact lost | Adjust device position |
| `Stream errors` | Device disconnected | Reconnect and restart streams |
| `High battery drain` | Continuous streaming | Stop streams when not needed |

### Debugging

```dart
// Enable verbose logging (main.dart)
void main() {
  // Set to verbose for debugging
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
}

// Log BLE operations
Future<Either<Failure, void>> connect(String deviceId) async {
  log.d('Connecting to device: $deviceId');
  try {
    await _polar.connectToDevice(deviceId);
    log.d('Connected successfully');
    return const Right(null);
  } catch (e) {
    log.e('Connection failed: $e');
    return Left(BLEFailure(e.toString()));
  }
}
```

---

## Dependencies

```yaml
# pubspec.yaml
dependencies:
  polar: ^7.5.1
  flutter_blue_plus: ^1.35.2
  permission_handler: ^11.3.1
```

---

## Related Documentation

- [State Management](./STATE_MANAGEMENT.md)
- [Database](./DATABASE.md)
- [Troubleshooting](./TROUBLESHOOTING.md)
- [Codebase Guide](./CODEBASE_GUIDE.md)
