import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';

class WithdrawalFlow {
  static Future<void> showSummary(BuildContext context, {required int amount}) async {

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (ctx) {
        return _BaseSheet(
          child: _WithdrawalSummaryContent(amount: amount),
        );
      },
    );
  }
}

/// Reusable base sheet container matching the Deposit/Withdrawal style
class _BaseSheet extends StatelessWidget {
  final Widget child;
  const _BaseSheet({required this.child});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: child,
      ),
    );
  }
}

/// Sheet 1: Withdrawal Summary
class _WithdrawalSummaryContent extends StatelessWidget {
  final int amount;
  const _WithdrawalSummaryContent({required this.amount});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // drag handle + icon
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),
                child: Icon(Icons.account_balance_wallet, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE)
                    , size: 26),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),

        Text(
          'N${_formatAmount(amount)}',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 12),

        // Bank info card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues()),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bank', style: TextStyle()),
                  Row(children: [
                    Icon(Icons.account_balance, size: 18, color: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE)
                    ),
                    const SizedBox(width: 6),
                    Text('Access Bank', style: TextStyle(color: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE), fontWeight: FontWeight.w600)),
                  ])
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Account Number'),
                  Text('2115456788', style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recipient Name'),
                  Text('Engr Unwana', style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // Amount breakdown
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Amount'),
            Text('N${_formatAmount(amount)}'),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Charged Fees'),
            Text('N20.00'),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recipient receive'),
            Text('N${_formatAmount(amount - 20)}'),
          ],
        ),

        const SizedBox(height: 12),

        // Wallet balance row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [Icon(Icons.account_balance_wallet_outlined, color: isLight
                  ? const Color(0xFF2B124C)
                  : const Color(0xFF632AAE)
              ), const SizedBox(width: 8), Text('Wallet (₦150.00)')]),
              TextButton(
                onPressed: () {},
                child: Text('Add Money'),
              )
            ],
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              Navigator.pop(context); // close summary sheet
              // open PIN sheet
              Future.delayed(const Duration(milliseconds: 150), () {
                _showPinSheet(context, amount: amount);
              });
            },
            child: Text('Pay ${_formatAmount(amount)}', style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  String _formatAmount(int a) => a.toString();
}

// Sheet 2: Enter Payment PIN
void _showPinSheet(BuildContext context, {required int amount}) {

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (ctx) => _BaseSheet(child: _PinSheetContent(amount: amount)),
  );
}

class _PinSheetContent extends StatefulWidget {
  final int amount;
  const _PinSheetContent({required this.amount});

  @override
  State<_PinSheetContent> createState() => _PinSheetContentState();
}

class _PinSheetContentState extends State<_PinSheetContent> {
  final List<int> _pin = [];

  void _onKey(int value) {
    setState(() {
      if (_pin.length < 4) _pin.add(value);
    });

    if (_pin.length == 4) {
      // auto-confirm after small delay
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pop(context); // close pin sheet
        _showLoadingDialog(context);
        // simulate processing and show success
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(); // close loading
          _showSuccessSheet(context);
        });
      });
    }
  }

  void _onBackspace() {
    setState(() {
      if (_pin.isNotEmpty) _pin.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;


    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Text('Enter Payment Pin', style: TextStyle( fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 12),

        // PIN boxes
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (i) {
            final filled = i < _pin.length;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE)
                ),
              ),
              child: Center(child: filled ? Icon(Icons.circle, size: 10, color: isLight
                  ? const Color(0xFF2B124C)
                  : const Color(0xFF632AAE)
              ) : const SizedBox()),
            );
          }),
        ),

        const SizedBox(height: 18),

        // Numeric keypad
        _buildKeypad(),

        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: Text('Forgot Payment Pin?', style: TextStyle(color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE)
          )),
        ),

        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: isLight
                  ? const Color(0xFF2B124C)
                  : const Color(0xFF632AAE), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                if (_pin.length == 4) {
                  Navigator.pop(context);
                  _showLoadingDialog(context);
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                    _showSuccessSheet(context);
                  });
                }
              },
              child: const Text('Confirm Withdrawal', style: TextStyle(color: Colors.white),),
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildKeypad() {
    return SizedBox(
      height: 260,
      child: Column(
        children: List.generate(4, (row) {
          final start = row * 3 + 1;
          final items = row == 3 ? [7, 8, 9] : [start, start + 1, start + 2];

          // adjust last row
          if (row == 3) items.setAll(0, [0, -1, -2]);

          return Expanded(
            child: Row(
              children: List.generate(3, (col) {
                final index = row * 3 + col;
                Widget child;

                if (row == 3 && col == 0) {
                  child = _KeyButton(label: '1', onTap: () => _onKey(1));
                } else if (row == 3 && col == 1) {
                  // zero
                  child = _KeyButton(label: '0', onTap: () => _onKey(0));
                } else if (row == 3 && col == 2) {
                  // backspace
                  child = _KeyButton(icon: Icons.backspace, onTap: _onBackspace);
                } else {
                  final val = row * 3 + col + 1;
                  child = _KeyButton(label: '$val', onTap: () => _onKey(val));
                }

                return Expanded(child: child);
              }),
            ),
          );
        }),
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;
  const _KeyButton({this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Center(
            child: icon != null
                ? Icon(icon, color: isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE))
                : Text(label ?? '', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}

// Loading dialog (full screen)
void _showLoadingDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Loading',
    transitionDuration: const Duration(seconds: 5),
    pageBuilder: (ctx, a, b) {

      return Container(
        color: Theme.of(context).colorScheme.surface,
        child: const Center(child: CircularProgressIndicator()),
      );
    },
  );
}

// Success sheet
void _showSuccessSheet(BuildContext context) {
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
          Icon(Icons.check_circle, size: 40, color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE)),
          const SizedBox(height: 14),
          Text('Withdrawal Successful!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            'You have successfully donated to Brother\'s Gathering, may the good lord bless you. Amen.',
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: isLight
                  ? const Color(0xFF2B124C)
                  : const Color(0xFF632AAE), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Go to Home', style: TextStyle(color: Colors.white),),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    ),
  );
}
