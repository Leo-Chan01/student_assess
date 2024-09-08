import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_assess/firebase_options.dart';
import 'package:student_assess/view_model/database/courses_model.dart';
import 'package:student_assess/view_model/providers/cgpa_calculator_provider.dart';
import 'package:student_assess/view_model/providers/file_picker_provider.dart';
import 'package:student_assess/view_model/providers/navigation_provider.dart';
import 'package:student_assess/view_model/utils/config/routes.dart';
import 'package:student_assess/view_model/utils/config/screen_size.dart';
import 'package:student_assess/view_model/utils/config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(CourseAdapter());
  await Hive.openBox<Course>('coursesBox');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<FilePickerProvider>(
        create: (context) => FilePickerProvider()),
    ChangeNotifierProvider<CgpaCalculatorProvider>(
        create: (context) => CgpaCalculatorProvider()),
    ChangeNotifierProvider<NavigationProvider>(
        create: (context) => NavigationProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          return ScreenUtilInit(
            designSize: DesignSizeConfig().designSize(
              orientation: orientation,
              constraints: constraints,
            ),
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            ensureScreenSize: true,
            rebuildFactor: (old, data) => true,
            builder: (context, child) {
              return MaterialApp.router(
                title: 'Student Assess',
                theme: AppTheme.instance.lightTheme,
                routerConfig: AppRoutes.router,
              );
            },
          );
        });
      },
    );
  }
}
