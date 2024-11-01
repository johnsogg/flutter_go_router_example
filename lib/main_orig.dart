import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate/components/scaffold_with_nested_navigation.dart';
import 'package:navigate/controllers/thing_controller.dart';
import 'package:navigate/screens/home.dart';
import 'package:navigate/screens/lists.dart';
import 'package:navigate/screens/looper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ListenableProvider<ThingController>(
        create: (_) => ThingController(),
      )
    ],
    child: const NavApp(),
  ));
}

final _rootNavKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final _goRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(navigatorKey: _shellNavKey, routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: HomeScreen());
            },
          ),
          GoRoute(
            path: '/looper',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: LooperScreen());
            },
          ),
          GoRoute(
            path: '/lists',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: ListsScreen());
            },
          ),
          // GoRoute(
          //   path: '/details',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const DetailsScreen();
          //   },
          // ),
        ]),
      ],
    ),
  ],
);

class NavApp extends StatelessWidget {
  const NavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _goRouter,
    );
  }
}

    // NavigationController navigation =
    //         Provider.of<NavigationController>(context);
    // return MaterialApp(
    //   home: Navigator(
    //     pages: [
    //       const MaterialPage(child: ListScreen()),
    //       if (navigation.screenName == '/settings')
    //         const MaterialPage(child: SettingsScreen()),
    //       if (navigation.screenName == '/about')
    //         const MaterialPage(child: AboutScreen()),
    //       if (navigation.screenName == '/details')
    //         const MaterialPage(child: DetailsScreen()),
    //     ],
    //     onDidRemovePage: (page) {
    //       // this onDidRemovePage function was added in Flutter 3, replacing
    //       // the onPagePop method from Flutter 2. The idea here is that the
    //       // given page should not be included in the next build of the
    //       // Navigator widget. We're manually building the pages array each
    //       // time in this example so it isn't necessary. But if we were keeping
    //       // the `pages` list for record keeping, we'd simply remove the given
    //       // page from it.
    //     },
    //   ),
    // );
