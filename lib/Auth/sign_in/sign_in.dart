import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/Auth/register/register_screen.dart';
import 'package:semi_bill/Auth/sign_in/forgot_password.dart';
import 'package:semi_bill/Auth/verify/verify_bvn.dart';
import 'package:semi_bill/home_screen.dart';
import '../auth_api.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_token_provider.dart';
import '../token_storage.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {

  // for password visibility
  bool _obscurePassword = true;

  //controllers for backend authentication
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginUser(BuildContext context) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    final email = emailController.text.trim();
    final password = passwordController.text;

    // Validation
    if (email.isEmpty || password.isEmpty) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password are required')),
      );
      return;
    }

    try {
      final authApi = ref.read(authApiProvider);

      final response = await authApi.login(
        email: email,
        password: password
      );

      //final token = response.data['token'];
      //await TokenStorage().saveToken(token);

      // DEBUG: see backend response
      if (kDebugMode) {
        print(response.data);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      final token = response.data['data']['token'];
      ref.read(authTokenProvider.notifier).state = token;


      // TODO: Save token later
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


  // reusable for text fields
  OutlineInputBorder roundedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isLight ? Colors.white : const Color(0xFF0F0F0F),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset( isLight ? 'assets/launchers/logo.png' : 'assets/launchers/logo_dark.png',
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      Text(
                        'Log', style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: isLight ? Colors.black : Colors.white
                      ),
                      ),
                      Text('in', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: isLight ? const Color(0xFF2B124C)
                              : const Color(0xFF632AAE)
                      ),),
                    ],
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                      labelText: 'Email Address or Phone Number',
                      border: roundedBorder(context),
                      enabledBorder: roundedBorder(context),
                      focusedBorder: roundedBorder(context),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                      labelText: 'Password',
                      border: roundedBorder(context),
                      enabledBorder: roundedBorder(context),
                      focusedBorder: roundedBorder(context),

                      suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
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
                      onPressed: isLoading ? null : () => loginUser(context),
                      child: isLoading
                          ? SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(isLight ? const Color(0xFF2B124C)
                              : const Color(0xFF632AAE)),
                        ),
                      ) : Text(
                        'Login',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Forgot Password?',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isLight? Colors.black : Colors.white
                      ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            // Navigate to forgot password screen
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Click here to reset',
                            style: TextStyle(
                              color: isLight? Colors.black : Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 80,),
                    Row(
                      children: [
                        Text(
                          "Don't have an account?",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isLight? Colors.black : Colors.white
                        ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              // Navigate to sign up screen
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              'Register Here',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isLight? Colors.black : Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                ],
              )),
        ),
      ),
    );
  }
}
