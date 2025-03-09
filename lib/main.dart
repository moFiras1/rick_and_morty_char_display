import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/modules/home/controller/home_controller.dart';

import 'core/app_router.dart';
import 'core/firebase_notifications/firebase_notifications.dart';
import 'firebase_options.dart';
import 'modules/char_details/controller/char_details_controller.dart';

final navigationKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseNotifications().initNotification();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseNotifications.instance.firebaseMessagingBackgroundHandler);
  await FirebaseNotifications.instance.setupFlutterNotifications();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeController()),
      ChangeNotifierProvider(create: (_) => CharDetailsController()),
    ],
    child: const MyApp(), // Register Controller])
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
