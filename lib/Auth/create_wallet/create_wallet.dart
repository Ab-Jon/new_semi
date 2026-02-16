import 'package:flutter/material.dart';
import 'package:semi_bill/bvn/bvn_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/presentation/wallet/wallet_screen.dart';
import 'create_wallet_provider.dart';
import 'package:semi_bill/bvn/bvn_verification.dart';

class CreateWallet extends ConsumerStatefulWidget {
  const CreateWallet({super.key});

  @override
  ConsumerState<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends ConsumerState<CreateWallet> {

  // Controllers
  final phoneController = TextEditingController();
  final otpController = TextEditingController();


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
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bvnState = ref.watch(bvnProvider);
    final walletState = ref.watch(createWalletProvider);

    /// ✅ LISTEN FOR SUCCESS / ERROR
    ref.listen(createWalletProvider, (prev, next) {
      if (prev?.success != true && next.success == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WalletScreen()),
        );
      }

      if (prev?.error != next.error && next.error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight ? Colors.white : const Color(0xFF0F0F0F),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
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
                    Text('Wallet', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: isLight ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE)
                    ),),
                  ],
                ),
                const SizedBox(height: 30),

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
                  initialValue: bvnState.bvn ?? '',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                    labelText: 'BVN',
                    border: roundedBorder(context),
                    enabledBorder: roundedBorder(context),
                    focusedBorder: roundedBorder(context),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:  isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                    labelText: 'OTP',
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
                    onPressed: walletState.loading
                        ? null
                        : () {
                      ref.read(createWalletProvider.notifier).createWallet(
                        phone: phoneController.text.trim(),
                        bvn: bvnState.bvn!,
                        otp: otpController.text.trim(),
                      );
                    },
                    child: walletState.loading
                        ? SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(isLight ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE)),
                      ),
                    ) : Text(
                      'Create',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
