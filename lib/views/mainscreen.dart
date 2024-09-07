import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:student_assess/view_model/utils/config/routes.dart';
import 'package:student_assess/view_model/utils/config/theme.dart';
import 'package:student_assess/views/cgpa_mainscreen.dart';
import 'package:student_assess/views/student_assess_page.dart';
import 'package:student_assess/views/student_profile_page.dart';

class Mainscreen extends StatelessWidget {
  Mainscreen({super.key});

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true, stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
      backgroundColor: AppTheme.instance.lightTheme.scaffoldBackgroundColor,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property
    );
  }

  List<Widget> _buildScreens() {
    return [
      const StudentAssessPage(),
      const CgpaMainscreen(),
      const StudentProfilePage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: ScrollController(),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: AppRoutes.homeRoute,
          routes: {
            AppRoutes.studentAssessRoute: (final context) =>
                const StudentAssessPage(),
            AppRoutes.studentProfileRoute: (final context) =>
                const StudentProfilePage(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.book),
        title: ("CGPA"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: ScrollController(),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: AppRoutes.homeRoute,
          routes: {
            AppRoutes.studentAssessRoute: (final context) =>
                const StudentAssessPage(),
            AppRoutes.cgpaMainRoute: (final context) => const CgpaMainscreen(),
            AppRoutes.studentProfileRoute: (final context) =>
                const StudentProfilePage(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: ScrollController(),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: AppRoutes.homeRoute,
          routes: {
            AppRoutes.studentAssessRoute: (final context) =>
                const StudentAssessPage(),
            AppRoutes.studentProfileRoute: (final context) =>
                const StudentProfilePage(),
          },
        ),
      ),
    ];
  }
}
