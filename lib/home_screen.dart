import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jbw_system/auth_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final User? currentUser = Supabase.instance.client.auth.currentUser;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.signOut(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: ${currentUser?.email ?? "Not available"}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'User ID: ${currentUser?.id ?? "Not available"}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Add quick action buttons
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                _buildQuickActionCard(
                  context,
                  'Profile',
                  Icons.person,
                  () => Get.toNamed('/profile'),
                ),
                _buildQuickActionCard(
                  context,
                  'Settings',
                  Icons.settings,
                  () => Get.toNamed('/settings'),
                ),
                _buildQuickActionCard(
                  context,
                  'Dashboard',
                  Icons.dashboard,
                  () => Get.toNamed('/dashboard'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
