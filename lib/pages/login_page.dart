import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You are signed in. Welcome to AuthFlow!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _openRegistration() async {
    final accountCreated = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(builder: (_) => const RegistrationPage()),
    );

    if (!mounted || accountCreated != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created. You can now sign in.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _AuthBrand(),
                  const SizedBox(height: 42),
                  Text(
                    'Welcome back',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.ink,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sign in to continue to your account.',
                    style: TextStyle(color: AppTheme.muted, fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          fieldKey: const ValueKey('login-identifier'),
                          controller: _identifierController,
                          label: 'Email or username',
                          hint: 'name@example.com',
                          icon: Icons.person_outline,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.username],
                          validator: (value) => (value?.trim().isNotEmpty ?? false)
                              ? null
                              : 'Enter your email or username.',
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          fieldKey: const ValueKey('login-password'),
                          controller: _passwordController,
                          label: 'Password',
                          hint: 'Enter your password',
                          icon: Icons.lock_outline,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                          obscureText: _hidePassword,
                          suffixIcon: IconButton(
                            tooltip: _hidePassword ? 'Show password' : 'Hide password',
                            onPressed: () => setState(() => _hidePassword = !_hidePassword),
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          validator: (value) => (value?.isNotEmpty ?? false)
                              ? null
                              : 'Enter your password.',
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password reset is not connected in this demo.'),
                        ),
                      ),
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(onPressed: _login, child: const Text('Log in')),
                  const SizedBox(height: 22),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: AppTheme.muted, fontSize: 14),
                      ),
                      TextButton(
                        onPressed: _openRegistration,
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthBrand extends StatelessWidget {
  const _AuthBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppTheme.mint,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.lock_person_outlined, color: AppTheme.ink, size: 24),
        ),
        const SizedBox(width: 12),
        const Text(
          'AuthFlow',
          style: TextStyle(
            color: AppTheme.ink,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}