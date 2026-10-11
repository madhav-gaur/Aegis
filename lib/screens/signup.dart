import 'dart:developer' as developer;

import 'package:aegis/components/buttons.dart';
import 'package:aegis/components/text_field.dart';
import 'package:aegis/router/routes.dart';
import 'package:aegis/services/auth_service.dart';
import 'package:aegis/themes/app_colors.dart';
import 'package:aegis/themes/app_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _error;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await AuthService().signup(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phoneNumber: _phoneController.text,
      );
      if (mounted) context.go(AppRoutes.app);
    } on FirebaseAuthException catch (exception) {
      if (!mounted) return;
      setState(
        () => _error = switch (exception.code) {
          'email-already-in-use' =>
            'An account already exists with this email.',
          'weak-password' => 'Password is too weak.',
          'invalid-email' => 'Enter a valid email address.',
          'operation-not-allowed' =>
            'Email and password sign-in is not enabled in Firebase.',
          _ => 'Could not create your account. Please try again.',
        },
      );
    } catch (error) {
      developer.log(
        'Failed to create the user account or save its profile.',
        error: error,
      );
      if (mounted) {
        setState(() {
          _error = 'Could not create your account. Please try again.';
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F0F172A),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create account',
                      style: AppFonts.screenTitle.copyWith(
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign up with your email and password.',
                      style: AppFonts.caption.copyWith(color: AppColors.muted),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    AppTextField(
                      controller: _nameController,
                      label: 'Name',
                      prefixIcon: Icons.person_outline,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        final name = value?.trim() ?? '';
                        if (name.length < 2 || name.length > 100) {
                          return 'Name must be between 2 and 100 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _phoneController,
                      label: 'Phone number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      hintText: '+14155552671',
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _passwordController,
                      label: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) {
                        if ((value?.length ?? 0) < 6) {
                          return 'Password must be at least 6 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirm password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _error!,
                        style: const TextStyle(color: Color(0xFFEF4444)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 16),
                    PrimaryButton(
                      label: 'Sign up',
                      onPressed: _handleSignUp,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () => context.go(AppRoutes.signin),
                      child: Text(
                        'Already have an account? Sign in',
                        style: AppFonts.caption.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
