import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.pickedAvatarImage});

  final void Function(File pickedImage) pickedAvatarImage;

  @override
  State<StatefulWidget> createState() {
    return _UserImagePicker();
  }
}

class _UserImagePicker extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 200);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.pickedAvatarImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.black12),
        child: Center(
          widthFactor: double.infinity,
          heightFactor: double.infinity,
          child: _pickedImageFile != null
              ? CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  foregroundImage: _pickedImageFile != null
                      ? FileImage(_pickedImageFile!)
                      : null,
                )
              : const Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}
