import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Observa mudanças no estado de autenticação
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Get.offAllNamed('/home');
      } else if (event == AuthChangeEvent.signedOut) {
        Get.offAllNamed('/login');
      }
    });
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      isLoading.value = true;

      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (res.user != null) {
        try {
          await supabase
              .from('user_profiles')
              .insert({'id': res.user!.id, 'email': email, 'nome': name, 'tipo': 'usuario', 'is_admin': false});

          Get.offAllNamed('/confirm-email', parameters: {'email': email});
        } catch (e) {
          print('Erro ao criar perfil: $e');
          Get.snackbar(
            'Atenção',
            'Conta criada mas houve erro no perfil',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      print('Erro no cadastro: $e');
      Get.snackbar(
        'Erro',
        'Falha no cadastro: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

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
        'Erro',
        'Login falhou: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

// Método para criar o primeiro admin
  Future<void> createFirstAdmin(String email, String password, String name) async {
    try {
      isLoading.value = true;

      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (res.user != null) {
        await supabase
            .from('user_profiles')
            .insert({'id': res.user!.id, 'email': email, 'nome': name, 'tipo': 'admin', 'is_admin': true});
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Método para verificar se o usuário está autenticado
  bool get isAuthenticated => supabase.auth.currentUser != null;

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    Get.offAllNamed('/login');
  }
}
