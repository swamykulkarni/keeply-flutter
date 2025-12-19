import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/appliance_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/my_appliances_screen.dart';
import 'screens/browse_appliances_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const KeeplyApp());
}

class KeeplyApp extends StatelessWidget {
  const KeeplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ApplianceProvider()),
      ],
      child: MaterialApp(
        title: 'Keeply AMC Tracker',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
          '/my-appliances': (context) => const MyAppliancesScreen(),
          '/browse-appliances': (context) => const BrowseAppliancesScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}