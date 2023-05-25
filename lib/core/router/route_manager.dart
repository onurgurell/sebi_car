import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/core/router/routes.dart';
import 'package:sebi_car/presentation/journey_creation/journey_creation_view.dart';
import 'package:sebi_car/presentation/home/home_view.dart';
import 'package:sebi_car/presentation/login/login_view.dart';
import 'package:sebi_car/view_model/home/journey_cretaion_view_model.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel(),
            child: const LoginView(),
          ),
        );
      case Routes.homePage:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case Routes.journeyCreation:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<JourneyCreationViewModel>(
            create: (_) => JourneyCreationViewModel(),
            child: const JourneyCreationView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Ups !'),
            ),
          ),
        );
    }
  }
}
