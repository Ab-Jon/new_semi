import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_api.dart';
import '../providers/auth_provider.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {

  // reusable for text fields
  OutlineInputBorder roundedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    );
  }

  bool isLoading = false;
  final emailController = TextEditingController();

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

      final response = await authApi.requestResetPassword(
        email: emailController.text.trim(),);

      if (kDebugMode) {
        print(response.data);
      } // debug backend response

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reset token sent to your email'),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 800));
      //Navigator.push(
       // context,
     //   MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: email)),
     // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send reset token'),
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isLight ? Colors.white : const Color(0xFF0F0F0F),
      ),
      backgroundColor: isLight ? Colors.white : const Color(0xFF0F0F0F),
      body: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset( isLight ? 'assets/launchers/logo.png' : 'assets/launchers/logo_dark.png',
                  height: 50,
                ),
              ),
              const SizedBox(height: 40),
                  Text(
                    'Forgot Password?', style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: isLight ? Colors.black : Colors.white
                  ),
                  ),
                  Text("Don't worry, it happens. Please enter the email address you signed up with", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isLight ? Colors.black
                          : Colors.white
                  ),),
              const SizedBox(height: 30),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                  labelText: 'Email Address',
                  border: roundedBorder(context),
                  enabledBorder: roundedBorder(context),
                  focusedBorder: roundedBorder(context),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Submit',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            ],
          )),
    );
  }
}
