import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';

void main() {
  runApp(const InstagramClone());
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData(                          // ← ThemeData starts here
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(          // ← AppBarTheme starts here
          backgroundColor: Colors.white,
          elevation: 1,
          titleTextStyle: TextStyle(             // ← TextStyle starts here
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),                                      // ← TextStyle ends here
          iconTheme: IconThemeData(color: Colors.black),
        ),                                        // ← AppBarTheme ends here
      ),                                          // ← ThemeData ends here
      home: const LoginScreen(),
    );                                            // ← MaterialApp ends here
  }
}