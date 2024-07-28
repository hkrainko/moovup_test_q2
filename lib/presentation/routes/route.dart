import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/presentation/home/home_screen.dart';
import 'package:moovup_test/presentation/map/map_screen.dart';
import 'package:moovup_test/presentation/people/person_screen.dart';
import 'package:moovup_test/presentation/shared/scaffold_with_navbar.dart';

part 'route.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

class MainBranch extends StatefulShellBranchData {
  const MainBranch();
}

class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class MapRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MapScreen();
  }
}

@TypedGoRoute<PersonRoute>(path: '/person/:personId')
@immutable
class PersonRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  final String personId;
  final Person $extra;

  const PersonRoute({required this.personId, required this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final Person person = state.extra as Person;
    return PersonScreen(person: person);
  }
}

@TypedStatefulShellRoute<MainSellRoute>(branches: [
  TypedStatefulShellBranch<MainBranch>(routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<HomeRoute>(
      path: '/home',
      name: 'home',
      routes: [],
    ),
  ]),
  TypedStatefulShellBranch<MainBranch>(routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<MapRoute>(
      path: '/map',
      name: 'map',
      routes: [],
    ),
  ]),
])
@immutable
class MainSellRoute extends StatefulShellRouteData {
  const MainSellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state,
      StatefulNavigationShell navigationShell) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}
