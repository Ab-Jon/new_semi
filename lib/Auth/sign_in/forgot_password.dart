import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/ui/semi_ui.dart';
import '../providers/auth_provider.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  bool isLoading = false;
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> requestPasswordReset(BuildContext context) async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      final authApi = ref.read(authApiProvider);
      final response = await authApi.requestResetPassword(email: email);

      if (kDebugMode) {
        print(response.data);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reset token sent to your email')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send reset token')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SemiAuthHeader(
                lead: 'Forgot ',
                accent: 'Password',
                subtitle:
                    "Don't worry, it happens. Enter the email you signed up with.",
              ),
              const SizedBox(height: 32),
              SemiField(
                controller: emailController,
                label: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              SemiButton(
                label: 'Submit',
                loading: isLoading,
                onPressed: () => requestPasswordReset(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
