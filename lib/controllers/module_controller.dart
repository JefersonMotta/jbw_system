import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module.dart';

class ModuleController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final RxList<Module> modules = <Module>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadModules();
  }

  Future<void> loadModules() async {
    try {
      isLoading.value = true;
      final response = await supabase.from('modules').select().order('ordem', ascending: true);

      modules.value = (response as List).map((data) => Module.fromJson(data)).toList();
    } catch (e) {
      print('Erro ao carregar módulos: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
