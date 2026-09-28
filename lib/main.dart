import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AuthFlowApp());
}

class AuthFlowApp extends StatelessWidget {
  const AuthFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginPage(),
    );
  }
}