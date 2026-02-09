# User Journeys

End-to-end user flows and interactions in HatoFit.

**Audience**: UX Designers, Product Managers, Stakeholders  
**Last Updated**: February 2026

---

## Journey 1: New User Onboarding

### Flow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                     NEW USER ONBOARDING                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  App Launch → Splash Screen → Onboarding → Account Creation →  │
│                                                         Home    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Steps

| Step | Screen | Actions | Duration |
|------|--------|---------|----------|
| 1 | Splash | App logo, brand animation | 2 seconds |
| 2 | Onboarding | Feature highlights (liquid swipe) | 30 seconds |
| 3 | Welcome | Get started button | 5 seconds |
| 4 | Auth Selection | Email or Google Sign-In | 10 seconds |
| 5 | Registration | Profile creation | 60 seconds |
| 6 | Home | Dashboard with options | Immediate |

### Key Touchpoints

- **First Impression**: Animated onboarding with liquid swipe
- **Friction Reduction**: Google Sign-In one-tap
- **Motivation**: Feature highlights showcasing Polar integration

---

## Journey 2: Connecting a Heart Rate Monitor

### Flow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                   HEART RATE MONITOR CONNECTION                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Device Tab → Scan → Select Device → Pair → Connect → Start    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Steps

| Step | Screen | Actions | Duration |
|------|--------|---------|----------|
| 1 | Device Screen | Tap "Add Device" | 5 seconds |
| 2 | Scan | Search for nearby devices | 10 seconds |
| 3 | Device List | Select Polar H10 | 5 seconds |
| 4 | Pairing | Confirm pairing dialog | 10 seconds |
| 5 | Connection | Establishing connection | 5 seconds |
| 6 | Ready | Device connected indicator | Immediate |

### Success Criteria

- Device appears in scan results
- Successful pairing on first attempt
- Connection maintained during workout

### Error Scenarios

| Error | User Action | Recovery |
|-------|-------------|----------|
| Device not found | Restart scan | Move closer to device |
| Pairing failed | Retry pairing | Clear device cache |
| Connection lost | Auto-reconnect | Manual reconnection |

---

## Journey 3: Completing a Workout

### Flow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                      WORKOUT COMPLETION                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Select Workout → Warm-up → Main Exercises → Cool-down → Summary│
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Steps

| Step | Screen | Actions | Duration |
|------|--------|---------|----------|
| 1 | Workout Library | Browse and select | 30 seconds |
| 2 | Workout Preview | Review exercises | 15 seconds |
| 3 | Start Workout | Connect HR, begin | 10 seconds |
| 4 | Exercise 1-N | Follow video, track HR | Variable |
| 5 | Completion | Save workout | 5 seconds |
| 6 | Summary | View stats, share | 30 seconds |

### Real-Time Data Display

| Metric | Update Frequency |
|--------|-----------------|
| Heart Rate | Every 1 second |
| Timer | Every second |
| Exercise Progress | Per exercise |
| Calories | Every 5 seconds |

---

## Journey 4: Viewing Progress

### Flow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                       PROGRESS VIEWING                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Home → History → Select Workout → Details → Export            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Available Views

| View | Description | Data Shown |
|------|-------------|------------|
| Weekly Summary | Last 7 days activity | Total workouts, time, calories |
| Monthly Trends | Monthly progress | Charts, comparisons |
| Workout Details | Single session data | HR zones, exercise breakdown |
| Achievements | Badges and milestones | Completed goals |

### Data Visualization

- **Charts**: Syncfusion line/bar charts
- **Gauges**: HR zone indicators
- **Cards**: Quick stat summaries

---

## Journey 5: Managing Profile

### Flow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                       PROFILE MANAGEMENT                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Settings → Profile → Edit → Save                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Actions Available

| Action | Screen | Result |
|--------|--------|--------|
| Update Avatar | Profile → Camera/Gallery | New photo displayed |
| Edit Metrics | Settings → Metrics | BMI recalculated |
| Change Theme | Settings → Appearance | Immediate switch |
| Set Language | Settings → Language | App restart required |

---

## User Pain Points & Solutions

| Pain Point | Solution |
|-----------|----------|
| Complex pairing process | Simplified single-tap pairing |
| Long workout load times | Offline caching |
| Unclear exercise instructions | Video demonstrations |
| Lost progress data | Cloud sync + local backup |

---

## Metrics to Track

| Journey | Key Metric | Target |
|---------|-----------|--------|
| Onboarding | Completion rate | >80% |
| Device Connection | Success rate | >90% |
| Workout | Completion rate | >75% |
| Progress View | Engagement frequency | >50% daily |

---

## Related Documentation

- [Features](FEATURES.md)
- [Business Logic](BUSINESS_LOGIC.md)
- [Analytics](../product/ANALYTICS.md)