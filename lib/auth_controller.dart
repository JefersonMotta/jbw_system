import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final RxBool isLoading = false.obs;

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user != null) {
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      isLoading.value = true;

      // Primeiro cria o usuário na autenticação
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (res.user != null) {
        try {
          // Depois cria o perfil do usuário usando o ID do usuário autenticado
          await supabase.from('users').upsert({
            'id': res.user!.id,
            'email': email,
            'nome': name,
            'tipo': 'usuario',
            'criado_em': DateTime.now().toIso8601String(),
          });

          // Redireciona para tela de confirmação ou home
          Get.offAllNamed('/confirm-email', parameters: {'email': email});
        } catch (erroProfile) {
          if (kDebugMode) {
            print('Erro ao criar perfil do usuário: $erroProfile');
          }
          Get.snackbar(
            'Atenção',
            'Conta criada mas houve erro no perfil. Contate o suporte.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro no cadastro: $e');
      }
      Get.snackbar(
        'Erro',
        'Falha no cadastro: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Add the signOut method
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign out failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Get current user
  User? get currentUser => supabase.auth.currentUser;

  // Check if user is logged in
  bool get isLoggedIn => currentUser != null;
}
