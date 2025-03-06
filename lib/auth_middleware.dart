import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return Supabase.instance.client.auth.currentUser == null ? const RouteSettings(name: '/login') : null;
  }
}
