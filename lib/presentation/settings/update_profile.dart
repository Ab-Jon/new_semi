import 'package:flutter/material.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // Mocked profile data. All images are network images.
  Map<String, String> profile = {
    'name': 'Boss Unwana',
    'email': 'ubokobong@gmail.com',
    'firstName': 'Ugochukwu',
    'lastName': 'Chikwado',
    'dob': '09/06/2022',
    'phone': '09034524562',
    'country': 'Nigeria',
    'town': 'Ugbokoposo',
    'city': 'Effurun',
    'lga': 'Uvwie',
    'state': 'Delta',
    'address': '21 Moses Udih',
    'nin': '23435567886',
    'avatar':
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=500&q=60', // network avatar
  };

  final _formKey = GlobalKey<FormState>();

  // Helper to open a simple edit dialog and update the profile map
  Future<void> _editField(String key, String title, {TextInputType? keyboardType}) async {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final controller = TextEditingController(text: profile[key]);
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(border: OutlineInputBorder(), hintText: title),
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel', style:
              TextStyle(color: isLight
                  ? const Color(0xFF2B124C)
                  : const Color(0xFF632AAE)),)),
            ElevatedButton(onPressed: () => Navigator.of(context).pop(controller.text.trim()),
                style: ElevatedButton.styleFrom(backgroundColor: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE)), child: const Text('Save')),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      setState(() => profile[key] = result);
    }
  }

  Widget _profileHeader() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              profile['avatar']!,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Name & email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile['name']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(profile['email']!, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
          // small lock icon under avatar in screenshot — show as small icon column
          Icon(Icons.camera_alt_outlined, color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE), size: 18),
        ],
      ),
    );
  }

  // row with label on left and value on right; optional edit icon
  Widget _twoColumnRow({
    required String label,
    required String value,
    bool editable = false,
    VoidCallback? onEdit,
    TextStyle? valueStyle,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // left label
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          // value + optional edit icon
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: valueStyle ?? const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                if (editable && onEdit != null) ...[
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: onEdit,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(Icons.edit, size: 18, color: isLight
                          ? const Color(0xFF2B124C)
                          : const Color(0xFF632AAE),),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _personalDetailsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header title
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Text(
              'Personal Details',
              style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1),

          // fields
          _twoColumnRow(
            label: 'First Name',
            value: profile['firstName']!,
            editable: true,
            onEdit: () => _editField('firstName', 'First Name'),
          ),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(
            label: 'Last Name',
            value: profile['lastName']!,
            editable: true,
            onEdit: () => _editField('lastName', 'Last Name'),
          ),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(
            label: 'Date of birth',
            value: profile['dob']!,
            editable: false,
          ),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(
            label: 'Phone Number',
            value: profile['phone']!,
            editable: true,
            onEdit: () => _editField('phone', 'Phone Number', keyboardType: TextInputType.phone),
          ),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(label: 'Country', value: profile['country']!),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(label: 'Town', value: profile['town']!),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(label: 'City', value: profile['city']!),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(label: 'LGA', value: profile['lga']!),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(label: 'State', value: profile['state']!),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(
            label: 'Address',
            value: profile['address']!,
            editable: true,
            onEdit: () => _editField('address', 'Address'),
          ),
          const Divider(height: 1, indent: 12, endIndent: 12),

          _twoColumnRow(label: 'NIN', value: profile['nin']!),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    // Main scaffold
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text('Update Profile', style: TextStyle(fontWeight: FontWeight.w600)),
        leading: const SemiBackButton(),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Profile header
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: _profileHeader(),
            ),

            // Personal details (scrollable below)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _personalDetailsCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Save changes button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Save action: For now we simply show a snack
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes saved')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
