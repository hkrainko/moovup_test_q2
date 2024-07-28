import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:moovup_test/injectable_config.dart';
import 'package:moovup_test/presentation/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(Environment.prod);
  runApp(const MyApp());
}

final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    routes: $appRoutes,
    navigatorKey: rootNavigatorKey);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Moovup Test',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        // canvasColor: Colors.green,
      ),
      // routerConfig: _router,
      routerConfig: _router,
    );
  }
}
