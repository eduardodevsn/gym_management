import 'package:flutter/material.dart';
import 'package:gym_management/core/di/injection_container.dart';
import 'package:gym_management/core/themes/app_theme.dart';
import 'package:gym_management/feature/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await initDependencies();
    print('✅ Dependencies initialized successfully');
  } catch (e, stackTrace) {
    print('❌ Error initializing dependencies: $e');
    print('Stack trace: $stackTrace');
  }
  
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GYM_APP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Placeholder(), // Placeholder temporal
        '/forgot-password': (context) => const Placeholder(),
      },
    );
  }
}