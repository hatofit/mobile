import 'package:flutter_blue_plus/flutter_blue_plus.dart';

final class GuidConstant {
  // heart rate service
  static final Guid hrS = Guid("180D");
  // device information service
  static final Guid diS = Guid("180A");
  // battery service
  static final Guid bsS = Guid("180F");

  // heart rate measurement characteristic
  static final Guid hrmC = Guid("2A37");
  // body sensor location characteristic
  static final Guid bslC = Guid("2A38");
  // manufacturer name string characteristic
  static final Guid mnsC = Guid("2A29");
  // battery level characteristic
  static final Guid blC = Guid("2A19");
}
