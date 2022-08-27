import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home/home_page.dart';

void main() async{ 
  // Needs to call when using native components or libraries
  //
  //For example: camera, bluetooth, GPS
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.openBox('todo_items'); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}

