import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hatofit/domain/domain.dart';
import 'package:hatofit/service_locator.dart';
import 'package:hatofit/ui/ui.dart';
import 'package:hatofit/utils/utils.dart';

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),

  greeting("/greeting"),
  preference("/preference"),
  userInfo("/user-info"),

  login("/auth/login"),
  register("/auth/register"),
  forgotPassword("/auth/forgot-password"),
  resetPassword("/auth/reset-password"),

  /// Home Page
  home("/home"),

  /// Company Page
  company("/company"),

  // Activity Page
  activity("/activity"),
  activityDetail("/activity/detail"),

  // Settings Page
  settings("/settings"),
  settingsProfile("/settings/profile"),
  settingsDeviceIntegration("/settings/device-integration"),

  // Workout Page
  workout("/company/workout"),
  workoutDetail("/workout/detail"),
  freeWorkout("/workout/free"),
  startFreeWorkout("/workout/free/start"),
  startCompanyWorkout("/workout/company/start"),
  ;

  const Routes(this.path);

  final String path;
}

class AppRoute {
  static late BuildContext context;
  static final _rootNavKey = GlobalKey<NavigatorState>();
  static final _homeShellNavKey = GlobalKey<NavigatorState>();
  static final _workoutShellNavKey = GlobalKey<NavigatorState>();
  static final _activityShellNavKey = GlobalKey<NavigatorState>();
  static final _settingShellNavKey = GlobalKey<NavigatorState>();

  AppRoute.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavKey,
    routes: [
      GoRoute(
        path: Routes.splashScreen.path,
        name: Routes.splashScreen.name,
        builder: (_, __) => BlocProvider(
          create: (_) => di<SplashCubit>()..init(),
          child: const SplashView(),
        ),
      ),
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        redirect: (_, __) => Routes.home.path,
      ),
      GoRoute(
        path: Routes.greeting.path,
        name: Routes.greeting.name,
        builder: (_, __) => const GreetingView(),
      ),
      GoRoute(
        path: Routes.login.path,
        name: Routes.login.name,
        builder: (_, __) => const LoginView(),
      ),
      ShellRoute(
        builder: (_, __, child) => BlocProvider<IntroCubit>(
          create: (_) => di<IntroCubit>()..init(),
          child: child,
        ),
        routes: [
          GoRoute(
            path: Routes.preference.path,
            name: Routes.preference.name,
            builder: (_, __) => const PreferenceView(),
          ),
          GoRoute(
            path: Routes.userInfo.path,
            name: Routes.userInfo.name,
            builder: (_, __) => const UserInfoView(),
          ),
          GoRoute(
            path: Routes.register.path,
            name: Routes.register.name,
            builder: (_, __) => const RegisterView(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.forgotPassword.path,
        name: Routes.forgotPassword.name,
        builder: (_, __) => const ForgotPasswordView(),
      ),
      GoRoute(
          path: Routes.resetPassword.path,
          name: Routes.resetPassword.name,
          builder: (_, state) {
            String email = state.extra as String;
            return ResetPasswordView(
              email: email,
            );
          }),
      StatefulShellRoute.indexedStack(
        builder: (_, state, navigationShell) => BlocProvider(
          create: (context) => di<NavigationCubit>()..init(),
          child: BottomNavigationView(
            navigationShell: navigationShell,
            state: state,
          ),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeShellNavKey,
            routes: [
              GoRoute(
                path: Routes.home.path,
                name: Routes.home.name,
                builder: (_, __) => BlocProvider(
                  create: (_) => di<HomeCubit>()..init(),
                  child: const HomeView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _workoutShellNavKey,
            routes: [
              GoRoute(
                path: Routes.company.path,
                name: Routes.company.name,
                builder: (_, __) => BlocProvider(
                  create: (_) => di<CompanyCubit>()..init(),
                  child: const CompanyView(),
                ),
              ),
              GoRoute(
                path: Routes.workout.path,
                name: Routes.workout.name,
                builder: (_, state) {
                  final extra = state.extra as Map<String, dynamic>;
                  final company = extra['company'] as CompanyEntity;

                  return BlocProvider(
                    create: (_) => di<WorkoutCubit>()
                      ..init(
                        companyId: company.id ?? 0,
                      ),
                    child: WorkoutView(company: company),
                  );
                },
              ),
              GoRoute(
                path: Routes.workoutDetail.path,
                name: Routes.workoutDetail.name,
                builder: (_, state) {
                  final extra = state.extra as Map<String, dynamic>;
                  final exercise = extra['exercise'] as ExerciseEntity;
                  log.f('EXERCISE: $exercise');
                  return BlocProvider(
                    create: (_) => di<WorkoutCubit>()..init(),
                    child: WorkoutDetailView(
                      exercise: exercise,
                      companyExerciseId: exercise.id ?? '',
                    ),
                  );
                },
              ),
              GoRoute(
                path: Routes.freeWorkout.path,
                name: Routes.freeWorkout.name,
                builder: (_, __) => BlocProvider(
                  create: (_) => di<WorkoutCubit>()..init(),
                  child: const FreeWorkoutView(),
                ),
              ),
              GoRoute(
                path: Routes.startFreeWorkout.path,
                name: Routes.startFreeWorkout.name,
                builder: (_, state) {
                  final extra = state.extra as StartExerciseParams;
                  return BlocProvider(
                    create: (_) => di<WorkoutCubit>()..init(),
                    child: StartFreeWorkoutView(
                      isFreeWorkout: true,
                      exercise: extra.exercise,
                      user: extra.user,
                      device: extra.device,
                    ),
                  );
                },
              ),
              GoRoute(
                path: Routes.startCompanyWorkout.path,
                name: Routes.startCompanyWorkout.name,
                builder: (_, state) {
                  final extra = state.extra as StartExerciseParams;
                  return BlocProvider(
                    create: (_) => di<WorkoutCubit>()..init(),
                    child: StartCompanyWorkoutView(
                      isFreeWorkout: false,
                      exercise: extra.exercise,
                      user: extra.user,
                      device: extra.device,
                      companyExerciseId: extra.companyExerciseId ?? '',
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _activityShellNavKey,
            routes: [
              GoRoute(
                path: Routes.activity.path,
                name: Routes.activity.name,
                builder: (_, __) => BlocProvider(
                  create: (_) => di<ActivityCubit>()..init(),
                  child: const ActivityView(),
                ),
              ),
              GoRoute(
                  path: Routes.activityDetail.path,
                  name: Routes.activityDetail.name,
                  builder: (_, state) {
                    final extra = state.extra as SessionEntity;

                    return BlocProvider(
                      create: (_) =>
                          di<ActivityCubit>()..getReportById(extra.id ?? ''),
                      child: ActivityDetailView(
                        session: extra,
                      ),
                    );
                  }),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingShellNavKey,
            routes: [
              GoRoute(
                  path: Routes.settings.path,
                  name: Routes.settings.name,
                  builder: (_, __) => const SettingsView()),
              GoRoute(
                  path: Routes.settingsProfile.path,
                  name: Routes.settingsProfile.name,
                  builder: (_, __) => const ProfileView()),
              GoRoute(
                  path: Routes.settingsDeviceIntegration.path,
                  name: Routes.settingsDeviceIntegration.name,
                  builder: (_, __) => const DeviceIntegrationView()),
            ],
          )
        ],
      ),
    ],
    initialLocation: Routes.splashScreen.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: GoRouterRefreshStream(
      context.read<AuthCubit>().stream,
    ),
    restorationScopeId: 'hatofitApp',
  );
}
