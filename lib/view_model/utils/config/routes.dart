import 'package:go_router/go_router.dart';
import 'package:student_assess/views/mainscreen.dart';
import 'package:student_assess/views/splash_screen.dart';
import 'package:student_assess/views/student_assess_page.dart';
import 'package:student_assess/views/student_profile_page.dart';

class AppRoutes {
  static String splashRoute = '/';
  static String homeRoute = '/home';
  static String studentAssessRoute = '/student-assess';
  static String studentProfileRoute = '/student-profile';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.homeRoute,
        builder: (context, state) => Mainscreen(),
      ),
      GoRoute(
        path: AppRoutes.studentAssessRoute,
        builder: (context, state) => StudentAssessPage(),
      ),
      GoRoute(
        path: AppRoutes.studentProfileRoute,
        builder: (context, state) => const StudentProfilePage(),
      ),
    ],
  );
}
