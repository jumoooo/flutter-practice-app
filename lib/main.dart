import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/counter_screen.dart';
import 'screens/bottom_navigation_screen.dart';
import 'screens/api_practice_screen.dart';
import 'screens/provider_testscreen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';

import 'providers/counter_provider.dart';
import 'providers/user_providers.dart';
import 'providers/theme_provider.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';

void main() async {
  // SharedPreferences 사용을 위해 필요
  WidgetsFlutterBinding.ensureInitialized();

  // 테마 Provider 미리 생성 및 저장된 테마 불러오기
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Chapter 1 - Flutter 학습',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomNavigationExampleScreen(),
        '/home': (context) => const HomeScreen(),
        '/counter': (context) => const MyHomePage(title: '카운터 & Todo 예제'),
        '/detail': (context) =>
            const DetailScreen(id: 11, title: 'Named Route 예제'),
        '/api-practice': (context) => const ApiPracticeScreen(),
        '/provider-test': (context) => const ProviderTestScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
