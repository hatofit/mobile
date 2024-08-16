import 'package:polar/polar.dart';

class HrSample extends PolarHrSample {
  final DateTime timeStamp;
  final int second;
  HrSample({
    required this.timeStamp,
    required this.second,
    required super.hr,
    required super.rrsMs,
    required super.contactStatus,
    required super.contactStatusSupported,
  });
}

class EcgSample extends PolarEcgSample {
  final int second;
  EcgSample({
    required this.second,
    required super.timeStamp,
    required super.voltage,
  });
}

class AccSample extends PolarAccSample {
  final int second;
  AccSample({
    required this.second,
    required super.timeStamp,
    required super.x,
    required super.y,
    required super.z,
  });
}

class GyroSample extends PolarGyroSample {
  final int second;
  GyroSample({
    required this.second,
    required super.timeStamp,
    required super.x,
    required super.y,
    required super.z,
  });
}

class MagnetometerSample extends PolarMagnetometerSample {
  final int second;
  MagnetometerSample({
    required this.second,
    required super.timeStamp,
    required super.x,
    required super.y,
    required super.z,
  });
}

class PpgSample extends PolarPpgSample {
  final int second;
  PpgSample({
    required this.second,
    required super.timeStamp,
    required super.channelSamples,
  });
}
