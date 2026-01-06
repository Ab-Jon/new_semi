// import 'package:flutter/material.dart';
// import '../../wallet/transfer/widget/pin_screen.dart';
// import 'airtime_summary.dart';
//
// class AirtimeAmountScreen extends StatelessWidget {
//   final String phone;
//   final String network;
//
//   const AirtimeAmountScreen({
//     super.key,
//     required this.phone,
//     required this.network,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isLight = Theme.of(context).brightness == Brightness.light;
//     final amounts = [50, 100, 200, 500, 1000, 2000];
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Airtime Details')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const CircleAvatar(child: Icon(Icons.person)),
//                 const SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [Text(phone), Text(network)],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 1.8,
//                 children: amounts.map((a) {
//                   return ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).colorScheme.surface,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'N$a',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 6),
//                         const Text('Pay'),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isLight
//                       ? const Color(0xFF2B124C)
//                       : const Color(0xFF632AAE),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: () {
//                   showWithdrawalSheet(context);
//                 },
//                 child: const Text(
//                   'Proceed',
//                   style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'airtime_summary.dart';

class AirtimeDetailsScreen extends StatelessWidget {
  const AirtimeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Airtime Details',
          style: TextStyle(
            color: isLight? Colors.black : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(color: isLight? Colors.black : Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _recipientRow(context),
                    const SizedBox(height: 24),
                    const Text(
                      'Top Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '₦ 50 - 500,000',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _amountCard(context),
                  ],
                ),
              ),
            ),
            _proceedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _recipientRow(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Umwana Jr Chiamso',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '₦120,000.00',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Icon(
          Icons.swap_horiz,
          color: Colors.grey,
        ),
        const Spacer(),
        Column(
          children: [
            /// 🔹 MTN LOGO PLACEHOLDER
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/images/mtn.png',
              width: 36,
              height: 36,),
            ),
            const SizedBox(height: 4),
            const Text(
              '08122334456',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _amountCard(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLight? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _amountTile(context, '₦200', 'Pay ₦200', selected: true,),
          _amountTile(context, '₦200', 'Pay ₦200'),
          _amountTile(context, '₦1000', 'Pay ₦1000'),
          _amountTile(context, '₦200', 'Pay ₦200'),
          _amountTile(context, '₦200', 'Pay ₦200'),
          _amountTile(context, '₦1000', 'Pay ₦1000'),
          _amountTile(context, '₦1000', 'Pay ₦1000'),
          _amountTile(context, '₦200', 'Pay ₦200'),
          _amountTile(context, '₦1000', 'Pay ₦1000'),
          _amountTile(context, '₦1000', 'Pay ₦1000'),
          _amountTile(context, '₦1000', 'Pay ₦1000'),
          _amountTile(context, '₦1000', 'Pay ₦1000'),
          _amountTile(context, '1000MB', '3 Days'),
          _amountTile(context, '1000MB', '3 Days'),
          _amountTile(context, '1000MB', '3 Days'),
        ],
      ),
    );
  }

  Widget _amountTile(
      BuildContext context,
      String title,
      String subtitle, {
        bool selected = false,
      }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      decoration: BoxDecoration(
        color: isLight? Colors.white54 : Colors.black54,
        borderRadius: BorderRadius.circular(12),
        border: selected
            ? Border.all(color: const Color(0xFF2B124C), width: 1.5)
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? const Color(0xFF2B124C) : isLight? Colors.black: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: isLight? Colors.black:Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _proceedButton(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () {
            showWithdrawalSheet(context);
          },
          child: const Text(
            'Proceed',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
