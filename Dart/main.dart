import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'materials_page.dart';
import 'schedule_page.dart';
import 'ranking_page.dart';
import 'user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserManager.init(); // shared_preferences 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.grey.withOpacity(0.1)),
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/materials': (context) => MaterialsPage(),
        '/schedule': (context) => SchedulePage(),
        '/ranking': (context) => RankingPage(),
      },
    );
  }
}
