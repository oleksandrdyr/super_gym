import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gym/Crud/init_crud.dart';
import 'package:flutter_gym/firebase_options.dart';
import 'package:flutter_gym/widgets/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  InitCrud.init();
  runApp(MyApp());
}
