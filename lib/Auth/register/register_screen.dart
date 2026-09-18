import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/Auth/sign_in/sign_in.dart';
import 'package:semi_bill/Auth/verify/verify_otp.dart';
import 'package:semi_bill/ui/semi_ui.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool _obscurePassword = true;
  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final refController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    refController.dispose();
    super.dispose();
  }

  Future<void> registerUser(BuildContext context) async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final phone = phoneController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final authApi = ref.read(authApiProvider);
      final response = await authApi.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        phone: phoneController.text.trim(),
        referral: refController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
      await Future.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerifyCodeScreen()),
      );

      if (kDebugMode) {
        print(response.data);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed. Try again')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SemiAuthHeader(
                lead: 'Create ',
                accent: 'Account',
                subtitle: 'Join SEMIBILL to pay bills and move money.',
              ),
              const SizedBox(height: 28),
              SemiField(
                controller: nameController,
                label: 'Full Name',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),
              SemiField(
                controller: emailController,
                label: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),
              SemiField(
                controller: phoneController,
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),
              SemiField(
                controller: passwordController,
                label: 'Password',
                obscure: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                onToggleObscure: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              const SizedBox(height: 14),
              SemiField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                obscure: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 14),
              SemiField(
                controller: refController,
                label: 'Referred By (optional)',
              ),
              const SizedBox(height: 24),
              SemiButton(
                label: 'Sign up',
                loading: isLoading,
                onPressed: () => registerUser(context),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                    );
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
