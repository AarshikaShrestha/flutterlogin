import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AuthFlowLogo extends StatelessWidget {
  const AuthFlowLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Auth',
              style: TextStyle(
                color: AppTheme.ink,
                fontFamily: 'Georgia',
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: 'Flow',
              style: TextStyle(
                color: AppTheme.teal,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}