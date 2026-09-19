import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
  };

  final _formKey = GlobalKey<FormState>();

  Future<void> _editField(String key, String title, {TextInputType? keyboardType}) async {
    final controller = TextEditingController(text: profile[key]);
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            autofocus: true,
            decoration: InputDecoration(hintText: title),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: context.brand)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (result != null && result.isNotEmpty) {
      setState(() => profile[key] = result);
    }
  }

  Widget _row(String label, String value, {bool editable = false, VoidCallback? onEdit}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style: TextStyle(color: context.semi.muted)),
          ),
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                if (editable && onEdit != null) ...[
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: onEdit,
                    child: Icon(Icons.edit_outlined, size: 16, color: context.brand),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Update Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SemiCard(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const SemiAvatar(size: 64),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile['name']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(
                          profile['email']!,
                          style: const TextStyle(color: SemiColors.brandBright, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.camera_alt_outlined, color: context.brand, size: 18),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SemiCard(
                    margin: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
                          child: Text(
                            'Personal Details',
                            style: TextStyle(color: context.semi.muted, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Divider(color: context.hairline),
                        _row('First Name', profile['firstName']!, editable: true, onEdit: () => _editField('firstName', 'First Name')),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('Last Name', profile['lastName']!, editable: true, onEdit: () => _editField('lastName', 'Last Name')),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('Date of birth', profile['dob']!),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('Phone Number', profile['phone']!, editable: true, onEdit: () => _editField('phone', 'Phone Number', keyboardType: TextInputType.phone)),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('Country', profile['country']!),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('Town', profile['town']!),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('City', profile['city']!),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('LGA', profile['lga']!),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('State', profile['state']!),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('Address', profile['address']!, editable: true, onEdit: () => _editField('address', 'Address')),
                        Divider(height: 1, indent: 12, endIndent: 12, color: context.hairline),
                        _row('NIN', profile['nin']!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
              child: SemiButton(
                label: 'Save Changes',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changes saved')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
