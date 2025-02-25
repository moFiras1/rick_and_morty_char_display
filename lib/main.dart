import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/modules/home/controller/home_controller.dart';

import 'core/app_router.dart';
import 'modules/char_details/controller/char_details_controller.dart';

final navigationKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => CharDetailsController()),
      ]
        ,child: const MyApp(), // Register Controller])
  ));
  }

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(320, 588),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigationKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        });
  }
}
