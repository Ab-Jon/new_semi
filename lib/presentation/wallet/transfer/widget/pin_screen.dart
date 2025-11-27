import 'package:flutter/material.dart';

class PaymentHelpers {
  /// Show PIN sheet
  static void showPinSheet(BuildContext context, {required int amount}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (ctx) => _BaseSheet(
        child: _PinContent(amount: amount),
      ),
    );
  }

  /// Loader dialog
  static void _showLoader(BuildContext context, int amount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (!Navigator.canPop(context)) return;
      Navigator.pop(context); // close loader

      Future.microtask(() => _showSuccessSheet(context));
    });
  }

  /// Success sheet
  static void _showSuccessSheet(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (ctx) => _BaseSheet(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Icon(
              Icons.check_circle,
              size: 40,
              color: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),
            ),
            const SizedBox(height: 14),
            const Text(
              "Withdrawal Successful!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              "You have successfully donated to Brother's Gathering, may the good lord bless you. Amen.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  "Go to Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}

/// Base sheet container
class _BaseSheet extends StatelessWidget {
  final Widget child;
  const _BaseSheet({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(top: false, child: child),
    );
  }
}

/// PIN sheet content
class _PinContent extends StatefulWidget {
  final int amount;
  const _PinContent({required this.amount});

  @override
  State<_PinContent> createState() => _PinContentState();
}

class _PinContentState extends State<_PinContent> {
  final List<int> _pin = [];

  void _onDigit(int value) {
    if (_pin.length >= 4) return;
    setState(() => _pin.add(value));

    if (_pin.length == 4) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (!mounted) return;
        Navigator.pop(context); // close PIN sheet
        PaymentHelpers._showLoader(context, widget.amount);
      });
    }
  }

  void _onBackspace() {
    if (_pin.isEmpty) return;
    setState(() => _pin.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text("Enter Payment Pin", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),

        // PIN dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (i) {
            bool filled = i < _pin.length;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),
                ),
              ),
              child: Center(
                child: filled
                    ? Icon(Icons.circle,
                    size: 10,
                    color: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE))
                    : const SizedBox(),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),

        // Keypad
        _buildKeypad(isLight),
        const SizedBox(height: 10),

        TextButton(
          onPressed: () {},
          child: Text(
            "Forgot Payment Pin?",
            style: TextStyle(color: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE)),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _buildKeypad(bool isLight) {
    List<List<String>> keys = [
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"],
      ["", "0", "⌫"],
    ];

    return SizedBox(
      height: 260,
      child: Column(
        children: keys.map((row) {
          return Expanded(
            child: Row(
              children: row.map((item) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          if (item == "⌫") {
                            _onBackspace();
                          } else if (item.isNotEmpty) {
                            _onDigit(int.parse(item));
                          }
                        },
                        child: Center(
                          child: item == "⌫"
                              ? Icon(Icons.backspace, color: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE))
                              : Text(item, style: const TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
