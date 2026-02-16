import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/Auth/sign_in/sign_in.dart';
import 'package:semi_bill/Auth/verify/verify_otp.dart';
import '../auth_api.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {

  // for password visibility
   bool _obscurePassword = true;

   bool isLoading = false;

   // controllers for backend communication
   final nameController = TextEditingController();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final confirmPasswordController = TextEditingController();
   final phoneController = TextEditingController();
   final refController = TextEditingController();

  // reusable for text fields
  OutlineInputBorder roundedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    );
  }


   Future<void> registerUser(BuildContext context) async {

     if (isLoading) return;

     setState(() => isLoading = true);


     // 1. Read values
     final name = nameController.text.trim();
     final email = emailController.text.trim();
     final password = passwordController.text;
     final confirmPassword = confirmPasswordController.text;
     final phone = phoneController.text.trim();
     final referral = refController.text.trim();

     // 2. Basic validation
     if (name.isEmpty ||
         email.isEmpty ||
         password.isEmpty ||
         confirmPassword.isEmpty ||
         phone.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Please fill all required fields')),
       );
       return;
     }

     if (password != confirmPassword) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Passwords do not match')),
       );
       return;
     }

     // 3. Call backend
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

       // 4. Success
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Registration successful')),
       );
       // ⏳ Small delay so the user sees the snackbar
       await Future.delayed(Duration(milliseconds: 800));

       // ✅ NAVIGATE TO SIGN IN
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => VerifyCodeScreen()),
       );

       if (kDebugMode) {
         print(response.data);
       } // token / user data

     } catch (e) {
       // 5. Error
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Registration failed. Try again')),
       );
     } finally {
       if (mounted) setState(() => isLoading = false);
     }
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
                        'Create ', style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: isLight ? Colors.black : Colors.white
                      ),
                      ),
                      Text('Account', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: isLight ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE)
                      ),),
                    ],
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                      labelText: 'Full Name',
                      border: roundedBorder(context),
                      enabledBorder: roundedBorder(context),
                      focusedBorder: roundedBorder(context),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: emailController,
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

                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                      labelText: 'Phone Number',
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

                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                      labelText: 'Confirm Password',
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

                  TextFormField(
                    controller: refController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                      labelText: 'Referred By',
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
                      onPressed: isLoading ? null : () => registerUser(context),
                      child: isLoading ? SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(isLight ? const Color(0xFF2B124C)
                              : const Color(0xFF632AAE)),
                        )
                      ): Text(
                        'Sign up',
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
        ),
      ),
    );
  }
}
