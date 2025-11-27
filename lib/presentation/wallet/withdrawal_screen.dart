import 'package:flutter/material.dart';
import '../../themes/withdraw_theme.dart';
import 'confirm_withdrawal.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});

  // NOTE: Using the local file paths you uploaded as "network" image URLs per your request.
  // Your toolchain will transform them into real URLs if needed.
  final String sampleAvatar1 = 'file:///mnt/data/work29.PNG';
  final String sampleAvatar2 = 'file:///mnt/data/work30.PNG';
  final String sampleAvatar3 = 'file:///mnt/data/work31.PNG';


  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdrawal'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.history, color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE),)),
        ],
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            // Balance block
            Column(
              children: [
                Text('Available', style: TextStyle( fontSize: 12)),
                const SizedBox(height: 6),
                Text('N450,000.00', style: TextStyle(fontSize: 12,)),
                const SizedBox(height: 16),
                Text('N2,000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,)),
                const SizedBox(height: 18),
              ],
            ),

            // Recipient account card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recipient Account', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Enter 10 digits Account Number',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text('Zenith Bank')),
                            Icon(Icons.arrow_forward_ios, size: 18, color: isLight
                                ? const Color(0xFF2B124C)
                                : const Color(0xFF632AAE),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Account owner confirm chip
                    Container(
                      decoration: BoxDecoration(
                        color: isLight
                            ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.check, color: Colors.white, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text('Chikwado Ugochukwu Augustine', style: const TextStyle(
                              fontWeight: FontWeight.w600,
                          color: Colors.white))),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text('Remark', style: TextStyle(fontSize: 13)),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Enter Description(Whats this for)'),
                      minLines: 1,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          WithdrawalFlow.showSummary(
                            context,
                            amount: 5000,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLight
                              ? const Color(0xFF2B124C)
                              : const Color(0xFF632AAE),
                        ),
                        child: const Text('Proceed Withdrawal', style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Real-time bank monitor card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 1,
              child: ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.monitor_heart, color: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE)),
                ),
                title: const Text('Real-time Bank Monitor'),
                subtitle: const Text('Confirm the strength of the bank'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE)),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 16),

            // Beneficiary selection
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select Beneficiary', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'search Beneficiary',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Beneficiary list items
                    _beneficiaryItem(context, sampleAvatar1, 'Jose Mourinho', 'Providus Bank - 6567554567'),
                    const Divider(height: 8),
                    _beneficiaryItem(context, sampleAvatar2, 'Jose Mourinho', 'Providus Bank - 6567554567'),
                    const Divider(height: 8),
                    _beneficiaryItem(context, sampleAvatar3, 'Jose Mourinho', 'Providus Bank - 6567554567'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _beneficiaryItem(BuildContext context, String imageUrl, String name, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 44,
        height: 44,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(44),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
      ),
      title: Text(name),
      subtitle: Text(subtitle),
      onTap: () {},
    );
  }
}
