import 'package:flutter/material.dart';
import 'package:flutter_gym/routers/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();

    return MaterialApp(
      title: 'Fire Chat',
      onGenerateRoute: appRouter.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    FirebaseAuth.instance.signOut();
    print('Log Out');
    super.dispose();
  }
}
