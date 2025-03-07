import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jbw_system/auth_controller.dart';
import '../controllers/module_controller.dart';

class DashboardScreen extends StatelessWidget {
  final ModuleController moduleController = Get.put(ModuleController());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().signOut(),
          ),
        ],
      ),
      body: Obx(() {
        if (moduleController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: moduleController.modules.length,
          itemBuilder: (context, index) {
            final module = moduleController.modules[index];
            return Card(
              child: InkWell(
                onTap: () => Get.toNamed(module.rota),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder, size: 48),
                    const SizedBox(height: 8),
                    Text(
                      module.nome,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
