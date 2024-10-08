import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/service_locator.dart';
import 'package:hatofit/ui/ui.dart';
import 'package:hatofit/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //   ),
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di<SettingsCubit>()..init()),
        BlocProvider(create: (_) => di<AuthCubit>()..init()),
      ],
      child: OKToast(
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, __) {
            AppRoute.setStream(context);

            return BlocBuilder<SettingsCubit, DataHelper>(builder: (_, data) {
              return MaterialApp.router(
                routerConfig: AppRoute.router,
                restorationScopeId: 'hatofitApp',
                localizationsDelegates: const [
                  Strings.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                builder: (c, child) {
                  return MediaQuery(
                    data: MediaQuery.of(c).copyWith(
                      textScaler: const TextScaler.linear(1),
                      alwaysUse24HourFormat: true,
                    ),
                    child: child ??
                        const Center(child: CircularProgressIndicator()),
                  );
                },
                title: Constants.appName,
                theme: themeLight(context),
                darkTheme: themeDark(context),
                locale: Locale(data.type ?? "en"),
                supportedLocales: L10n.all,
                themeMode: data.activeTheme.mode,
              );
            });
          },
        ),
      ),
    );
  }
}
