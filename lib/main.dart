import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study_app_admin/firebase_options.dart';
import 'core/route/route_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'feature/admin/upload_course/domain/entities/course_entity.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await Hive.initFlutter();
    Hive.registerAdapter(CourseEntityAdapter());
    var course = await Hive.openBox<CourseEntity>('courses');
    var token = await Hive.openBox('accessToken');
    var note = await Hive.openBox('notes');

    await token.get('accessToken');
    await note.get('countryList');
    await note.get('schoolList');
    course.get('courses');

    await dotenv.load();

    FlutterError.onError = (FlutterErrorDetails details) {
      if (!kReleaseMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) {
    if (!kReleaseMode) {
      debugPrint('Caught async error: $error');
      debugPrint('Stack trace: $stackTrace');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: route,
    );
  }
}
