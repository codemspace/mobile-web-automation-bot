import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  // constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(64, 105, 225, 1);
    final backColor = Color.fromRGBO(255, 255, 225, 1);

    return Center(
      child: Stack(children: [
        buildImage(backColor),
        Positioned(
          child: buildEditIcon(color),
          right: 4,
          top: 10,
        )
      ]),
    );
  }

  Widget buildImage(Color color) {
    final imageProvider = getImageProvider(imagePath);

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: imageProvider,
        radius: 70,
      ),
    );
  }

  ImageProvider getImageProvider(String imagePath) {
    if (imagePath.contains('http://') || imagePath.contains('https://')) {
      return NetworkImage(imagePath);
    } else if (imagePath.startsWith('assets/')) {
      return AssetImage(imagePath);
    } else {
      return FileImage(File(imagePath));
    }
  }

  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
