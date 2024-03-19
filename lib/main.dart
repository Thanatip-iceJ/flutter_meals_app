import 'package:flutter/material.dart';
import 'package:flutter_meals/screens/tabs_screen.dart';
import 'package:flutter_meals/screens/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: initialTheme, home: const TabsScreen());
  }
}
