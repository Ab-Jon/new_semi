import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerPreview extends StatefulWidget {
  final Function(XFile?) onImageSelected;
  const PhotoPickerPreview({super.key, required this.onImageSelected});

  @override
  State<PhotoPickerPreview> createState() => _PhotoPickerPreviewState();
}

class _PhotoPickerPreviewState extends State<PhotoPickerPreview> {
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () async {
                  Navigator.pop(context);
                  final img = await _picker.pickImage(source: ImageSource.camera);
                  setState(() => _selectedImage = img);
                  widget.onImageSelected(img);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  final img = await _picker.pickImage(source: ImageSource.gallery);
                  setState(() => _selectedImage = img);
                  widget.onImageSelected(img);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE)),
          image: _selectedImage != null
              ? DecorationImage(
            image: FileImage(File(_selectedImage!.path)),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: _selectedImage == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey.shade600),
            const SizedBox(height: 8),
            Text(
              "Add a photo",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
            : Stack(
          children: [
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                onTap: () {
                  setState(() => _selectedImage = null);
                  widget.onImageSelected(null);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

