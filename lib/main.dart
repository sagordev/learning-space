import 'package:flutter/material.dart';
import 'package:learning_space/views/app/auth/login.dart';
import 'package:learning_space/views/app/dashboard/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  String initRoute = '/login';

  runApp(MyApp(initialRoute: initRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Space',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        primaryColor: const Color(0xffff2950),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xffff2950)
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor:   Color(0xffff2950)
        ),
        inputDecorationTheme: const InputDecorationTheme(

          focusColor: Colors.black,
          prefixIconColor: Color(0xffff2950),

          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey)
          ),
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xffe7e7e7))
          ),
          errorBorder:  OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.redAccent)
          ),
          focusedErrorBorder:  OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.redAccent)
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffff2950)
          )
        )
        // primarySwatch: Colors.pink,
        // useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        '/login' : (context) => const Login(),
        '/dashboard' : (context) => const Dashboard()
      },
    );
  }
}
