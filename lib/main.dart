import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:products/screens/screens.dart';
import 'package:products/services/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>ProductsService())
    ],
    child: const MyApp(),);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
        'product': (_) => const ProductScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300], 
        appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.indigo, elevation: 0)
        ),
      );
  }
}