import 'package:get/get.dart';
import 'package:jbw_system/auth_middleware.dart';
import 'package:jbw_system/confirm_email_screen.dart';
import 'package:jbw_system/home_screen.dart';
import 'package:jbw_system/login_screen.dart';
import 'package:jbw_system/register_screen.dart';

class Routes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/register', page: () => RegisterScreen()),
    GetPage(name: '/confirm-email', page: () => ConfirmEmailScreen()),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
