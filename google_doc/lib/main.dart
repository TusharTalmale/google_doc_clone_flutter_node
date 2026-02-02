import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/services/offline_sync_service.dart';
import 'package:google_doc/utils/app_theme.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for offline storage
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(PendingOperationAdapter());
  Hive.registerAdapter(DocumentModelAdapter()); // For caching

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: true,
        builder: (context) => const GoogleDocsApp(),
      ),
    ),
  );
}

class GoogleDocsApp extends ConsumerWidget {
  const GoogleDocsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Initialize offline sync service
    ref.watch(offlineSyncServiceProvider);

    return MaterialApp.router(
      // Device Preview Configuration
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      
      title: 'Google Docs Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Corrected from ThemeMode.lightTheme
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: FlutterQuillLocalizations.supportedLocales,
    );
  }
}
