import 'package:flutter/material.dart';
import 'package:rick_and_morty/modules/home/view/home_view.dart';
import '../modules/char_details/view/char_details_view.dart';
import '../modules/favorite/view/favorite_view.dart';

class Routes {
  static const String homeViewRoute = '/';
  static const String characterDetailsRoute = '/char_Details_screen';
  static const String favorite = '/favorite_screen';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final Map<String, dynamic>? args =
    routeSettings.arguments as Map<String, dynamic>?;

    switch (routeSettings.name) {

      case Routes.homeViewRoute:
        return MaterialPageRoute(builder: (context) {
          return const HomeView();
        });

      case Routes.characterDetailsRoute:
        if (args == null || !args.containsKey('characterId')) {
          return undefinedRoute(); //
        }
        return MaterialPageRoute(
          builder: (context) => CharDetailsScreen(
            characterId: args['characterId'],
          ),

        );

      case Routes.favorite:
        return MaterialPageRoute(builder: (context) {
          return  FavoriteView();
        });
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text("Not found"),
          ),
        ));
  }
}
