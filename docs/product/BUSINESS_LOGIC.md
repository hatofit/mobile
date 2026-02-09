# Business Logic

Domain rules, calculations, and business requirements for HatoFit.

**Audience**: Business Analysts, Developers, QA Engineers  
**Last Updated**: February 2026

---

## Heart Rate Calculations

### Maximum Heart Rate

**Formula**: `Max HR = 220 - Age`

| Age | Max HR |
|-----|--------|
| 20 | 200 |
| 30 | 190 |
| 40 | 180 |
| 50 | 170 |
| 60 | 160 |

### Heart Rate Zones

| Zone | Percentage | Purpose | Color |
|------|------------|---------|-------|
| Resting | 50-60% | Warm-up | Gray |
| Fat Burn | 60-70% | Weight loss | Blue |
| Cardio | 70-80% | Endurance | Green |
| Peak | 80-90% | High intensity | Orange |
| VO2 Max | 90-100% | Maximum effort | Red |

### Zone Calculation

```dart
int calculateZone(int currentHr, int maxHr) {
  final percentage = (currentHr / maxHr) * 100;
  
  if (percentage < 60) return 1; // Resting
  if (percentage < 70) return 2; // Fat Burn
  if (percentage < 80) return 3; // Cardio
  if (percentage < 90) return 4; // Peak
  return 5; // VO2 Max
}
```

---

## Calorie Calculations

### MET-Based Formula

**Calories = MET × Weight(kg) × Duration(hours)**

### Exercise MET Values

| Exercise | MET Value |
|----------|-----------|
| Resting | 1.0 |
| Light stretching | 2.5 |
| Walking | 3.5 |
| Cycling (moderate) | 7.0 |
| Running | 9.0 |
| HIIT | 11.0 |

### Heart Rate Adjusted Calories

For workouts with HR monitoring:

```
Calories = Base Calories × (1 + (Actual HR / Max HR) × 0.5)
```

---

## BMI Calculation

**Formula**: `BMI = Weight(kg) / Height(m)²`

| BMI Range | Classification |
|-----------|---------------|
| < 18.5 | Underweight |
| 18.5 - 24.9 | Normal |
| 25 - 29.9 | Overweight |
| 30+ | Obese |

---

## Workout Session Rules

### Session States

| State | Description | Transitions |
|-------|-------------|--------------|
| `pending` | Created but not started | → `in_progress` |
| `in_progress` | Currently active | → `completed`, `cancelled` |
| `completed` | Finished successfully | Final state |
| `cancelled` | User stopped early | Final state |

### Session Duration Rules

- **Minimum Duration**: 1 minute
- **Maximum Duration**: 4 hours
- **Idle Timeout**: 5 minutes (auto-pause)

---

## User Account Rules

### Password Requirements

- Minimum 8 characters
- At least 1 uppercase letter
- At least 1 lowercase letter
- At least 1 number
- At least 1 special character

### Session Timeout

| State | Timeout Duration |
|-------|-----------------|
| Active | 30 minutes inactivity |
| Background | 5 minutes |
| Locked | Immediate (PIN/biometric required) |

---

## Data Retention

| Data Type | Retention Period | Storage Location |
|-----------|-----------------|------------------|
| Workout history | 2 years | Cloud + Local |
| Heart rate data | Session only | Local only |
| Profile data | Until deletion | Cloud + Local |
| Analytics data | 1 year | Cloud (anonymized) |

---

## Device Pairing Rules

### Maximum Paired Devices

| Device Type | Maximum |
|-------------|---------|
| Heart Rate Monitors | 3 |
| Fitness trackers | 2 |

### Connection Priority

1. Last connected device
2. Previously paired devices
3. New device discovery

---

## Business Rules Summary

| Rule | Requirement | Priority |
|------|-------------|----------|
| Age verification | Minimum 13 years | High |
| HR zone display | Real-time updates | High |
| Data sync | Automatic on connection | Medium |
| Offline support | Core features | Medium |

---

## Related Documentation

- [Features](FEATURES.md)
- [User Journeys](USER_JOURNEYS.md)