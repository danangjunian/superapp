import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/routing/app_router.dart';
import 'src/services/supabase_service.dart';
import 'src/theme/app_theme.dart';

/// Entry point of the super app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Supabase before running the app.
  await SupabaseService.initialize();
  runApp(const ProviderScope(child: SchoolSuperApp()));
}

/// Root widget for the school application.
class SchoolSuperApp extends StatelessWidget {
  const SchoolSuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = buildAppTheme();
    final router = buildRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // Use a concise and descriptive title for the new project.
      title: 'SuperApp',
      theme: theme,
      routerConfig: router,
    );
  }
}
