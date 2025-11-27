import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';

class SelectBankPage extends StatefulWidget {
  const SelectBankPage({super.key});

  @override
  State<SelectBankPage> createState() => _SelectBankPageState();
}

class _SelectBankPageState extends State<SelectBankPage> {
  List<Map<String, String>> banks = [
    {"name": "Access", "logo": "assets/access.png"},
    {"name": "Zenith", "logo": "assets/zenith.png"},
    {"name": "Access", "logo": "assets/access.png"},
    {"name": "Access", "logo": "assets/access.png"},
    {"name": "Access", "logo": "assets/access.png"},
    {"name": "Access", "logo": "assets/access.png"},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final colors = Theme.of(context).extension<AppColors>()!;
    final scheme = Theme.of(context).colorScheme;

    final filtered = banks
        .where((b) => b["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Text("Select Bank"),
        centerTitle: true,
        iconTheme: IconThemeData(color: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE)),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [

          // SEARCH FIELD
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 18),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 46,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (v) => setState(() => searchQuery = v),
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE)),
                labelText: "search Bank name",
                border: InputBorder.none,
              ),
            ),
          ),

          // MATCHED BANK HEADER
          Text(
            "Matched Bank",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          // MATCHED BANK BOX
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _bankLogo("assets/access.png"),
                const SizedBox(width: 10),
                _bankLogo("assets/zenith.png"),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ALPHABET SECTION A
          _alphabetHeader("A", scheme ),

          ...filtered.map((b) => _bankItem(b, colors, scheme)),

          const SizedBox(height: 20),

          // Next alphabet example
          _alphabetHeader("B", scheme),
          _bankItem({"name": "Access", "logo": "assets/access.png"}, colors, scheme),
        ],
      ),
    );
  }

  // Bank Logo Widget
  Widget _bankLogo(String path) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Image.asset(path, height: 32),
    );
  }

  // Alphabet header
  Widget _alphabetHeader(String letter, ColorScheme scheme) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          letter,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Divider(color: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE)),
        const SizedBox(height: 6),
      ],
    );
  }

  // Bank Item Row
  Widget _bankItem(Map<String, String> bank, AppColors colors, ColorScheme scheme) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context, bank["name"]);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Image.asset(bank["logo"]!, height: 28),
                const SizedBox(width: 12),
                Text(
                  bank["name"]!,
                  style: TextStyle(
                    fontSize: 16,
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(color: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE)),
      ],
    );
  }
}
