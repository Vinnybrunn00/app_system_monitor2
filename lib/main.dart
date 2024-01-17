import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:system_monitor/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'System Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme()
      ),
      home: const HomeScreen(),
    );
  }
}