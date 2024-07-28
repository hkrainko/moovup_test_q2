// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $personRoute,
      $mainSellRoute,
    ];

RouteBase get $personRoute => GoRouteData.$route(
      path: '/person/:personId',
      parentNavigatorKey: PersonRoute.$parentNavigatorKey,
      factory: $PersonRouteExtension._fromState,
    );

extension $PersonRouteExtension on PersonRoute {
  static PersonRoute _fromState(GoRouterState state) => PersonRoute(
        personId: state.pathParameters['personId']!,
        $extra: state.extra as Person,
      );

  String get location => GoRouteData.$location(
        '/person/${Uri.encodeComponent(personId)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $mainSellRoute => StatefulShellRouteData.$route(
      factory: $MainSellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              name: 'home',
              factory: $HomeRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/map',
              name: 'map',
              factory: $MapRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainSellRouteExtension on MainSellRoute {
  static MainSellRoute _fromState(GoRouterState state) => const MainSellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MapRouteExtension on MapRoute {
  static MapRoute _fromState(GoRouterState state) => MapRoute();

  String get location => GoRouteData.$location(
        '/map',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
