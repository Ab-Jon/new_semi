import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/Auth/register/register_screen.dart';
import 'package:semi_bill/Auth/sign_in/forgot_password.dart';
import 'package:semi_bill/Auth/verify/verify_bvn.dart';
import 'package:semi_bill/home_screen.dart';
import 'package:semi_bill/ui/semi_ui.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_token_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool _obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(BuildContext context) async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password are required')),
      );
      return;
    }

    try {
      final authApi = ref.read(authApiProvider);
      final response = await authApi.login(email: email, password: password);

      if (kDebugMode) {
        print(response.data);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      final token = response.data['data']['token'];
      ref.read(authTokenProvider.notifier).state = token;

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BvnInputScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
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
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SemiAuthHeader(
                lead: 'Log',
                accent: 'in',
                subtitle: 'Welcome back. Enter your details to continue.',
              ),
              const SizedBox(height: 32),
              SemiField(
                controller: emailController,
                label: 'Email Address or Phone Number',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              SemiField(
                controller: passwordController,
                label: 'Password',
                obscure: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onToggleObscure: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              const SizedBox(height: 24),
              SemiButton(
                label: 'Login',
                loading: isLoading,
                onPressed: () => loginUser(context),
              ),
              const SizedBox(height: 20),
              _AuthLinkRow(
                question: 'Forgot Password?',
                action: 'Click here to reset',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPassword()),
                  );
                },
              ),
              const SizedBox(height: 48),
              _AuthLinkRow(
                question: "Don't have an account?",
                action: 'Register Here',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  child: const Text('Explore the app'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthLinkRow extends StatelessWidget {
  const _AuthLinkRow({
    required this.question,
    required this.action,
    required this.onTap,
  });

  final String question;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            action,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
