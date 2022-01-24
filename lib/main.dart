import 'package:flutter/material.dart';
import 'package:myfile_app/widgets/guide.dart';

void main() {
  runApp(const MaterialApp(
    title: 'My File',
    // theme: ,
    home: SafeArea(
      child: MyFile(),
    ),
  ));
}

class MyFile extends StatelessWidget {
  const MyFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Guide(),
    );
  }
}
