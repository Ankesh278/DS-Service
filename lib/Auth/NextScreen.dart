// Next Screen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Screen")),
      body: Center(child: Text("Welcome to the Next Screen!")),
    );
  }
}