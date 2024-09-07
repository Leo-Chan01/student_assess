import 'package:flutter/material.dart';

class CgpaMainscreen extends StatelessWidget {
  const CgpaMainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text("Hello I'm the CGPA GEE"),
          ],
        )),
      ),
    );
  }
}
