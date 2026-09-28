import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_flow_logo.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _hidePassword = true;
  bool _hideConfirmation = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _createAccount() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.canvas,
        leading: IconButton(
          tooltip: 'Back to login',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthFlowLogo(),
                  const SizedBox(height: 30),
                  Text(
                    'Create your account',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.ink,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A few details and you are ready to go.',
                    style: TextStyle(color: AppTheme.muted, fontSize: 15),
                  ),
                  const SizedBox(height: 26),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          fieldKey: const ValueKey('register-name'),
                          controller: _nameController,
                          label: 'Full name',
                          hint: 'Your name',
                          icon: Icons.badge_outlined,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.name],
                          validator: (value) => (value?.trim().isNotEmpty ?? false)
                              ? null
                              : 'Enter your full name.',
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          fieldKey: const ValueKey('register-email'),
                          controller: _emailController,
                          label: 'Email address',
                          hint: 'name@example.com',
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) return 'Enter your email address.';
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
                              return 'Enter a valid email address.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          fieldKey: const ValueKey('register-password'),
                          controller: _passwordController,
                          label: 'Password',
                          hint: 'At least 8 characters',
                          icon: Icons.lock_outline,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.newPassword],
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
                          validator: (value) {
                            if (value?.isEmpty ?? true) return 'Create a password.';
                            if (value!.length < 8) return 'Use at least 8 characters.';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          fieldKey: const ValueKey('register-confirm-password'),
                          controller: _confirmPasswordController,
                          label: 'Confirm password',
                          hint: 'Enter your password again',
                          icon: Icons.lock_reset_outlined,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.newPassword],
                          obscureText: _hideConfirmation,
                          suffixIcon: IconButton(
                            tooltip: _hideConfirmation ? 'Show password' : 'Hide password',
                            onPressed: () => setState(() => _hideConfirmation = !_hideConfirmation),
                            icon: Icon(
                              _hideConfirmation
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) return 'Confirm your password.';
                            if (value != _passwordController.text) {
                              return 'Passwords do not match.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _createAccount,
                    child: const Text('Create account'),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: AppTheme.muted, fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Log in'),
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
