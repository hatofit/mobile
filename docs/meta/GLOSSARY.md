# Glossary

This glossary defines technical terms, abbreviations, and domain-specific terminology used throughout the HatoFit documentation and codebase.

---

## A

**API (Application Programming Interface)**  
A set of protocols and tools that allows different software applications to communicate with each other. HatoFit uses REST APIs for backend communication.

**APK (Android Package Kit)**  
The package file format used by Android to distribute and install mobile apps.

**Architecture Pattern**  
A reusable solution to commonly occurring problems in software architecture. HatoFit uses Clean Architecture.

**Async/Await**  
Dart programming pattern for handling asynchronous operations without blocking the main thread.

---

## B

**BLoC (Business Logic Component)**  
A design pattern for managing state in Flutter applications. It separates business logic from UI.

**BLE (Bluetooth Low Energy)**  
A wireless personal area network technology designed for short-range communication with low power consumption. Used for connecting heart rate monitors.

**BMI (Body Mass Index)**  
A measurement of body fat based on height and weight. Calculated as weight (kg) / height (m)².

**Build Runner**  
A Dart tool for generating code from annotations (e.g., JSON serialization, dependency injection).

---

## C

**Clean Architecture**  
A software architecture philosophy that separates concerns into layers: Domain, Data, and Presentation.

**Cubit**  
A simplified version of BLoC in the flutter_bloc library that doesn't require events, only states.

**CSV (Comma-Separated Values)**  
A file format for storing tabular data where values are separated by commas.

**CRUD (Create, Read, Update, Delete)**  
The four basic operations of persistent storage.

---

## D

**Dart**  
The programming language used for Flutter development, developed by Google.

**Dependency Injection (DI)**  
A design pattern where objects receive their dependencies from external sources rather than creating them internally. HatoFit uses GetIt for DI.

**Domain Layer**  
The innermost layer of Clean Architecture containing business logic, entities, and use cases.

**DTO (Data Transfer Object)**  
An object that carries data between processes, often used for API responses.

---

## E

**Entity**  
A domain object with a distinct identity that persists over time. In HatoFit: User, Workout, Exercise.

**Equatable**  
A Dart package that simplifies value comparisons by automatically implementing equality checks.

---

## F

**Firebase**  
Google's mobile platform that provides backend services like authentication, analytics, and crash reporting.

**Flutter**  
Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

**Freezed**  
A Dart package for creating immutable classes with built-in support for JSON serialization and equality.

**Functional Programming**  
A programming paradigm where programs are constructed by applying and composing functions.

---

## G

**GetIt**  
A simple service locator for Dart and Flutter, used for dependency injection in HatoFit.

**GATT (Generic Attribute Profile)**  
The Bluetooth protocol that defines how BLE devices communicate. Used for heart rate data.

**GPS (Global Positioning System)**  
A satellite-based navigation system (not currently used in HatoFit but planned for future features).

**GUI (Graphical User Interface)**  
The visual interface through which users interact with the application.

---

## H

**Hive**  
A lightweight and fast key-value database written in pure Dart, used for local data storage in HatoFit.

**HR (Heart Rate)**  
The number of heartbeats per minute, measured in BPM (beats per minute).

**HR Zone (Heart Rate Zone)**  
A range of heart rates based on a percentage of maximum heart rate:
- **Resting**: 50-60% max HR
- **Fat Burn**: 60-70% max HR
- **Cardio**: 70-80% max HR
- **Peak**: 80-90% max HR

**HTTP (Hypertext Transfer Protocol)**  
The foundation of data communication on the World Wide Web.

---

## I

**IDE (Integrated Development Environment)**  
A software application that provides comprehensive facilities for software development (e.g., Android Studio, VS Code).

**Immutable**  
An object whose state cannot be modified after creation. Used extensively in HatoFit for state management.

**i18n (Internationalization)**  
The process of designing software to support multiple languages and regions.

**IPA (iOS App Store Package)**  
The package file format used by iOS to distribute and install mobile apps.

---

## J

**JSON (JavaScript Object Notation)**  
A lightweight data interchange format used for API communication.

**JWT (JSON Web Token)**  
A compact, URL-safe means of representing claims to be transferred between parties. Used for authentication.

---

## K

**Key-Value Store**  
A data storage paradigm designed for storing, retrieving, and managing associative arrays. Hive is a key-value store.

---

## L

**Linting**  
The automated checking of source code for programmatic and stylistic errors.

**Localization (L10n)**  
The process of adapting software for a specific region or language. HatoFit supports English and Bahasa Indonesia.

---

## M

**Max HR (Maximum Heart Rate)**  
The highest heart rate an individual can achieve during physical exertion. Estimated as 220 - age.

**Met (Metabolic Equivalent of Task)**  
A unit for measuring exercise intensity. 1 MET = resting energy expenditure.

**MVC (Model-View-Controller)**  
A software design pattern (not used in HatoFit, which uses Clean Architecture).

**MVVM (Model-View-ViewModel)**  
A software architectural pattern (similar concepts used in HatoFit's presentation layer).

---

## N

**NoSQL**  
A non-relational database that stores data in a non-tabular format. Hive is a NoSQL database.

---

## O

**OAuth**  
An open standard for access delegation, used for Google Sign-In authentication.

**Offline Mode**  
App functionality available without an internet connection.

---

## P

**Polar SDK**  
Software Development Kit provided by Polar Electro for integrating with their heart rate monitors.

**Pubspec**  
The `pubspec.yaml` file that defines a Dart/Flutter package's dependencies and metadata.

---

## R

**Reactive Programming**  
A programming paradigm oriented around data streams and the propagation of change.

**Repository Pattern**  
A design pattern that mediates between the domain and data mapping layers.

**REST (Representational State Transfer)**  
An architectural style for designing networked applications. HatoFit uses REST APIs.

**RESTful API**  
An API that follows REST architectural constraints.

---

## S

**SDK (Software Development Kit)**  
A collection of tools for developing applications for a specific platform.

**Service Locator**  
A design pattern that uses a central registry to provide dependencies. HatoFit uses GetIt as a service locator.

**Singleton**  
A design pattern that restricts a class to a single instance.

**State Management**  
The process of managing the state (data) of an application. HatoFit uses BLoC/Cubit.

**Stream**  
A sequence of asynchronous events in Dart. Used for real-time data like heart rate monitoring.

---

## T

**Theme**  
A set of colors, fonts, and styles that define the visual appearance of the app. HatoFit supports Light and Dark themes.

**TTL (Time To Live)**  
The lifespan of data in a cache before it's considered stale.

---

## U

**UI (User Interface)**  
The space where interactions between humans and machines occur.

**URI (Uniform Resource Identifier)**  
A string of characters that unambiguously identifies a resource.

**Use Case**  
A list of actions or event steps defining the interactions between a user and a system to achieve a goal.

**UUID (Universally Unique Identifier)**  
A 128-bit number used to identify information in computer systems.

**UX (User Experience)**  
The overall experience of a person using the app, especially in terms of how easy or pleasing it is to use.

---

## V

**ViewModel**  
A component in the presentation layer that exposes data to the view and handles user interactions.

**VO2 Max**  
The maximum rate of oxygen consumption measured during incremental exercise (planned feature).

---

## W

**Widget**  
The basic building block of Flutter UI. Everything in Flutter is a widget.

**Workout Session**  
A single instance of a user performing exercises, tracked from start to finish.

**Workout Flow**  
The sequence of screens and interactions during a workout.

---

## X

**XML (eXtensible Markup Language)**  
A markup language that defines rules for encoding documents. Used in Android configuration.

---

## Y

**YAML (YAML Ain't Markup Language)**  
A human-readable data serialization standard. Used in `pubspec.yaml` for dependencies.

---

## Fitness-Specific Terms

### Exercise Intensity
| Term | Description | Heart Rate Range |
|------|-------------|------------------|
| **Resting** | Complete rest or very light activity | 50-60% max HR |
| **Warm-up** | Low intensity, preparing body for exercise | 50-60% max HR |
| **Fat Burn** | Moderate intensity, optimal for fat metabolism | 60-70% max HR |
| **Aerobic** | Moderate to high intensity, improves cardiovascular fitness | 70-80% max HR |
| **Anaerobic** | High intensity, builds muscle and endurance | 80-90% max HR |
| **VO2 Max** | Maximum effort, peak performance zone | 90-100% max HR |

### Workout Metrics
- **BPM**: Beats per minute (heart rate)
- **Calories**: Energy expenditure measured in kcal
- **Duration**: Total time of workout in minutes
- **Distance**: Distance covered (for applicable exercises)
- **Sets/Reps**: Number of exercise sets and repetitions

### Device Terms
- **HRM**: Heart Rate Monitor
- **BLE**: Bluetooth Low Energy
- **GATT**: Generic Attribute Profile
- **Sensor**: Device that detects heart rate
- **Pairing**: Process of connecting a BLE device to the app

---

## Acronyms Reference

| Acronym | Full Form |
|---------|-----------|
| API | Application Programming Interface |
| APK | Android Package Kit |
| BLoC | Business Logic Component |
| BLE | Bluetooth Low Energy |
| BMI | Body Mass Index |
| BPM | Beats Per Minute |
| CI/CD | Continuous Integration/Continuous Deployment |
| CRUD | Create, Read, Update, Delete |
| CSV | Comma-Separated Values |
| DI | Dependency Injection |
| DTO | Data Transfer Object |
| GATT | Generic Attribute Profile |
| GPS | Global Positioning System |
| GUI | Graphical User Interface |
| HR | Heart Rate |
| HRM | Heart Rate Monitor |
| HTTP | Hypertext Transfer Protocol |
| IDE | Integrated Development Environment |
| IPA | iOS App Store Package |
| JSON | JavaScript Object Notation |
| JWT | JSON Web Token |
| L10n | Localization |
| MVVM | Model-View-ViewModel |
| NoSQL | Not Only SQL |
| OAuth | Open Authorization |
| REST | Representational State Transfer |
| SDK | Software Development Kit |
| SQL | Structured Query Language |
| SSL | Secure Sockets Layer |
| TLS | Transport Layer Security |
| TTL | Time To Live |
| UI | User Interface |
| URI | Uniform Resource Identifier |
| UUID | Universally Unique Identifier |
| UX | User Experience |
| VO2 | Volume of Oxygen |
| XML | eXtensible Markup Language |
| YAML | YAML Ain't Markup Language |

---

## Related Documentation

- [Architecture Overview](../technical/ARCHITECTURE.md)
- [Code Style Guide](../contributing/CODE_STYLE.md)
- [Dependencies List](DEPENDENCIES.md)

---

**Last Updated**: February 2026