# Analytics Documentation

Metrics definitions, KPIs, and data tracking for HatoFit.

**Audience**: Data Analysts, Product Managers, Stakeholders  
**Last Updated**: February 2026

---

## Analytics Overview

HatoFit tracks user behavior and app performance through Firebase Analytics and custom event tracking.

---

## Key Performance Indicators

### User Acquisition

| KPI | Definition | Target | Current |
|-----|------------|--------|---------|
| Downloads | Total app installs | 500K/mo | 450K |
| Registration Rate | % who create account | 60% | 55% |
| Activation Rate | % who complete onboarding | 80% | 75% |

### Engagement

| KPI | Definition | Target | Current |
|-----|------------|--------|---------|
| DAU/MAU Ratio | Daily engagement ratio | 25% | 22% |
| Session Duration | Average time per session | 15 min | 12 min |
| Sessions/Day | Average daily sessions | 1.5 | 1.3 |

### Retention

| KPI | Definition | Target | Current |
|-----|------------|--------|---------|
| D1 Retention | Return after day 1 | 50% | 48% |
| D7 Retention | Return after day 7 | 30% | 28% |
| D30 Retention | Return after day 30 | 15% | 12% |

### Core Actions

| KPI | Definition | Target | Current |
|-----|------------|--------|---------|
| Workout Completion | % started workouts finished | 75% | 72% |
| Device Pairing | % users with HR monitor | 40% | 35% |
| Feature Adoption | % using specific features | Varies | Varies |

---

## Tracked Events

### Authentication Events

| Event | Description | Parameters |
|-------|-------------|------------|
| `login` | User logs in | method |
| `sign_up` | New registration | method |
| `logout` | User logs out | - |
| `password_reset` | Password recovery | - |

### Workout Events

| Event | Description | Parameters |
|-------|-------------|------------|
| `workout_start` | Workout initiated | type, duration |
| `workout_complete` | Workout finished | type, duration, calories |
| `workout_cancel` | Workout abandoned | type, reason |
| `exercise_view` | Exercise viewed | exercise_id |
| `video_play` | Video started | video_id, duration |

### Heart Rate Events

| Event | Description | Parameters |
|-------|-------------|------------|
| `hr_device_pair` | Device paired | device_type, brand |
| `hr_device_connect` | Connection established | device_id |
| `hr_stream_start` | HR monitoring began | device_id |
| `hr_zone_change` | Zone transition | from_zone, to_zone |

### Feature Usage

| Event | Description | Parameters |
|-------|-------------|------------|
| `search` | Search performed | query, results_count |
| `filter_apply` | Filter used | filter_type |
| `share_workout` | Workout shared | platform |
| `export_data` | Data exported | format |

---

## User Properties

| Property | Type | Description |
|----------|------|-------------|
| `user_type` | string | free, premium |
| `total_workouts` | int | Lifetime workouts |
| `device_count` | int | Paired devices |
| `subscription_status` | string | active, expired, none |
| `preferred_language` | string | en, id |
| `theme_preference` | string | light, dark, system |

---

## Dashboard Metrics

### Executive Dashboard

- Daily Active Users (DAU)
- Monthly Active Users (MAU)
- New User Registrations
- Workout Completions
- Revenue (subscriptions)

### Product Dashboard

- Feature Adoption Rates
- User Flow Completion
- Error/Crash Rates
- Session Duration
- Popular Workouts

### Technical Dashboard

- App Launch Time
- API Response Times
- Crash-Free Users Rate
- ANR (Application Not Responding) Rate
- Battery Impact

---

## Retention Cohorts

### Cohort Definition

Users grouped by:
- Sign-up date (weekly cohorts)
- Acquisition source
- First workout completion

### Cohort Metrics Tracked

| Cohort | Week 1 | Week 2 | Week 3 | Week 4 |
|--------|--------|--------|--------|--------|
| Jan 1-7 | 100% | 45% | 30% | 22% |
| Jan 8-14 | 100% | 42% | 28% | - |
| Jan 15-21 | 100% | 48% | - | - |

---

## Conversion Funnels

### Registration Funnel

```
App Open → Sign Up Started → Email Verified → Profile Created → Onboarding Complete
   100%    →     70%     →      60%      →       55%      →        45%
```

### Workout Funnel

```
Home Screen → Workout Selected → Started → Completed
   100%     →      60%      →    50%     →     40%
```

### Device Pairing Funnel

```
HR Tab → Scan Started → Device Found → Pairing → Connected
  100%   →     60%    →      50%    →    40%   →    35%
```

---

## Data Export

### Available Exports

| Format | Frequency | Contents |
|--------|-----------|----------|
| CSV | On-demand | Raw event data |
| BigQuery | Daily | Complete dataset |
| API | Real-time | Aggregated metrics |

### Data Retention

| Data Type | Retention |
|-----------|-----------|
| Event data | 2 years |
| User properties | Until deletion |
| Aggregated metrics | Indefinite |

---

## Privacy & Compliance

### GDPR Compliance

- User consent for analytics
- Data deletion on request
- Anonymized reporting

### Data Anonymization

| Data Type | Anonymization Method |
|-----------|---------------------|
| User IDs | Hashed before storage |
| Location | Regional aggregation |
| Health data | Session-based only |

---

## Tools & Integration

### Primary Analytics

- **Firebase Analytics**: Core tracking
- **Firebase Crashlytics**: Error monitoring
- **Firebase Performance**: Performance monitoring

### Business Intelligence

- **Tableau**: Custom dashboards
- **BigQuery**: Data warehousing
- **Looker**: Self-service analytics

---

## Reporting Schedule

| Report | Frequency | Audience |
|--------|-----------|----------|
| Daily Summary | Daily | Product team |
| Weekly Report | Weekly | Stakeholders |
| Monthly Review | Monthly | Executive team |
| Quarterly Review | Quarterly | Board |

---

## Related Documentation

- [Features](FEATURES.md)
- [User Journeys](USER_JOURNEYS.md)
- [Product Overview](PRODUCT_OVERVIEW.md)