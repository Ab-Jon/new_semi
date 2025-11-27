import 'package:flutter/material.dart';

class CableTvPage extends StatelessWidget {
  const CableTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cable Tv',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Banner Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://images.pexels.com/photos/442150/pexels-photo-442150.jpeg',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // White form container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Cable'),
                  const SizedBox(height: 5),
                  _buildDropdown(['DSTV', 'GOTV', 'StarTimes']),

                  const SizedBox(height: 15),
                  const Text('Decoder Number'),
                  const SizedBox(height: 5),
                  _buildTextField('Enter decoder number'),

                  const SizedBox(height: 15),
                  const Text('Viewing Package'),
                  const SizedBox(height: 5),
                  _buildDropdown(['DSTV Access', 'DSTV Premium', 'Compact']),

                  const SizedBox(height: 15),
                  const Text('Name'),
                  const SizedBox(height: 5),
                  _buildTextField('Customer name'),

                  const SizedBox(height: 15),
                  const Text('Select Pricing Option'),
                  const SizedBox(height: 5),
                  _buildDropdown(['Weekly', 'Monthly', 'Yearly']),

                  const SizedBox(height: 15),
                  const Text('Amount'),
                  const SizedBox(height: 5),
                  _buildTextField('0.00'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D0C4E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text('Make Payment', style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) {},
          hint: const Text('Select'),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
