import 'package:flutter/material.dart';
import 'dart:io';

class Fullscreen extends StatelessWidget {
  final String imagepath;

  const Fullscreen({required this.imagepath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Image.file(File(imagepath)), 
      ),
    );
  }
}
