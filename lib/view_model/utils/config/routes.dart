import 'package:go_router/go_router.dart';
import 'package:student_assess/views/cgpa/cgpa_calculate_screen.dart';
import 'package:student_assess/views/cgpa/cgpa_mainscreen.dart';
import 'package:student_assess/views/cgpa/cgpa_register_screen.dart';
import 'package:student_assess/views/mainscreen.dart';
import 'package:student_assess/views/splash_screen.dart';
import 'package:student_assess/views/student_assesment/student_assess_page.dart';
import 'package:student_assess/views/student_profile/student_profile_page.dart';

class AppRoutes {
  static String splashRoute = '/';
  static String homeRoute = '/home';
  static String studentAssessRoute = '/student-assess';
  static String studentProfileRoute = '/student-profile';
  static String cgpaMainRoute = '/cgpa-main';
  static String cgpaRegisterCoursesRoute = '/cgpa-register-course';
  static String cgpaCalculateCgpaRoute = '/cgpa-calculate';

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
        builder: (context, state) => const StudentAssessPage(),
      ),
      GoRoute(
        path: AppRoutes.studentProfileRoute,
        builder: (context, state) => const StudentProfilePage(),
      ),
      GoRoute(
          path: AppRoutes.cgpaMainRoute,
          builder: (context, state) => const CgpaMainscreen()),
      GoRoute(
          path: AppRoutes.cgpaRegisterCoursesRoute,
          builder: (context, state) => const CgpaRegisterScreen()),
      GoRoute(
          path: AppRoutes.cgpaCalculateCgpaRoute,
          builder: (context, state) => const CgpaCalculateScreen()),
    ],
  );
}
