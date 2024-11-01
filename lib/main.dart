import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This is a copy of the example from go_router's documentation, which I've
// edited lightly and re-documented in a way that I think is more helpful.
//
// https://raw.githubusercontent.com/flutter/packages/refs/heads/main/packages/go_router/example/lib/stateful_shell_route.dart
//
// This shows how to use stateful "shell" routes. You can switch between the
// shells using the bottom nav bar. Each shell maintains its own navigation
// stack. So for example when you're in the "Home" section, you can use the
// back button to go back to the previous sceen within the Home section, but
// you can't press Back to get to (for example) something in the "User" shell.

// keys are used to identify the 'shells'. It doesn't seem like these are
// necessary unless you really need to refer to the shell from somewhere else.
// Flutter will make default keys for you.
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

void main() {
  runApp(NestedTabNavigationExampleApp());
}

class NestedTabNavigationExampleApp extends StatelessWidget {
  NestedTabNavigationExampleApp({super.key});

  // We only need to define a single instance of GoRouter. This example uses
  // nested StatefulShellRoute instances that are used to show the various
  // screens.
  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/a',
    routes: [
      // The 'root' route is the one (and only) that includes the bottom nav
      // bar. This is what lets you transition between sections without the
      // "slide in" animation, which would tell users that the back button
      // should work. We don't want it to do that when user switches shells.
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        // The 'branches' of the root are the shells appearing in the app bar.
        branches: <StatefulShellBranch>[
          // First route is a shell
          StatefulShellBranch(
            // this is not necessary, left in for example
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/a',
                builder: (BuildContext context, GoRouterState state) =>
                    const RootScreen(label: 'A', detailsPath: '/a/details'),
                routes: <RouteBase>[
                  // The details screen to display stacked on navigator of the
                  // first tab. This will cover screen A but not the application
                  // shell (bottom navigation bar).
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) =>
                        const DetailsScreen(label: 'A'),
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            // It's not necessary to provide a navigatorKey if it isn't also
            // needed elsewhere. If not provided, a default key will be used.
            // navigatorKey: not used!
            routes: <RouteBase>[
              GoRoute(
                path: '/b',
                builder: (BuildContext context, GoRouterState state) =>
                    const RootScreen(
                  label: 'B',
                  detailsPath: '/b/details/1',
                  secondDetailsPath: '/b/details/2',
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details/:param',
                    builder: (BuildContext context, GoRouterState state) =>
                        DetailsScreen(
                      label: 'B',
                      param: state.pathParameters['param'],
                    ),
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/c',
                builder: (BuildContext context, GoRouterState state) =>
                    const RootScreen(
                  label: 'C',
                  detailsPath: '/c/details',
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) =>
                        DetailsScreen(
                      label: 'C',
                      extra: state.extra,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Section B'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Section C'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({
    required this.label,
    required this.detailsPath,
    this.secondDetailsPath,
    super.key,
  });

  final String label;
  final String detailsPath;
  final String? secondDetailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Root of section $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(detailsPath, extra: '$label-XYZ');
              },
              child: const Text('View details'),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            if (secondDetailsPath != null)
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go(secondDetailsPath!);
                },
                child: const Text('View more details'),
              ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    required this.label,
    this.param,
    this.extra,
    this.withScaffold = true,
    super.key,
  });

  final String label;
  final String? param;
  final Object? extra;
  final bool withScaffold;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.withScaffold) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Details Screen - ${widget.label}'),
        ),
        body: _build(context),
      );
    } else {
      return ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: _build(context),
      );
    }
  }

  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Details for ${widget.label} - Counter: $_counter',
              style: Theme.of(context).textTheme.titleLarge),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Increment counter'),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.param != null)
            Text('Parameter: ${widget.param!}',
                style: Theme.of(context).textTheme.titleMedium),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.extra != null)
            Text('Extra: ${widget.extra!}',
                style: Theme.of(context).textTheme.titleMedium),
          if (!widget.withScaffold) ...<Widget>[
            const Padding(padding: EdgeInsets.all(16)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('< Back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ]
        ],
      ),
    );
  }
}
