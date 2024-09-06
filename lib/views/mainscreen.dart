import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:student_assess/view_model/utils/config/routes.dart';
import 'package:student_assess/view_model/utils/config/theme.dart';
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
      padding: const EdgeInsets.only(top: 8),
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
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.simple, // Choose the nav bar style with this property
    );
  }

  List<Widget> _buildScreens() {
    return [const StudentAssessPage(), const StudentProfilePage()];
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
