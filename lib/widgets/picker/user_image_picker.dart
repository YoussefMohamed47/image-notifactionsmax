import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickeImage) imagepickfn;
  UserImagePicker(this.imagepickfn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = pickedImageFile as File;
    });
    widget.imagepickfn(pickedImageFile as File);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          radius: 40,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            _pickImage();
          },
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
