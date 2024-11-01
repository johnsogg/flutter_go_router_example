import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate/controllers/thing_controller.dart';
import 'package:navigate/screens/about.dart';
import 'package:navigate/screens/details.dart';
import 'package:navigate/screens/list.dart';
import 'package:navigate/screens/settings.dart';
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

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/about',
          builder: (BuildContext context, GoRouterState state) {
            return const AboutScreen();
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
        GoRoute(
          path: '/details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
      ],
    ),
  ],
);

class NavApp extends StatelessWidget {
  const NavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
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
