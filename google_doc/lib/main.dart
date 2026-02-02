import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/services/offline_sync_service.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:google_doc/utils/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for offline storage
  await Hive.initFlutter();
  
  // Register Hive adapters
  Hive.registerAdapter(PendingOperationAdapter());
  Hive.registerAdapter(DocumentModelAdapter()); // For caching
  
  runApp(
    const ProviderScope(
      child: GoogleDocsApp(),
    ),
  );
}

class GoogleDocsApp extends ConsumerWidget {
  const GoogleDocsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Google Docs Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        // Initialize offline sync service
        ref.read(offlineSyncServiceProvider);
        
        return MediaQuery(
          // Ensure text scaling doesn't break layout
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}