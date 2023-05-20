import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/core/router/routes.dart';
import 'package:sebi_car/presentation/home/home_view.dart';
import 'package:sebi_car/presentation/login/login_view.dart';
import 'package:sebi_car/view_model/home/home_view_model.dart';
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
          builder: (_) => ChangeNotifierProvider<HomeViewModel>(
            create: (_) => HomeViewModel(),
            child: const HomeView(),
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
