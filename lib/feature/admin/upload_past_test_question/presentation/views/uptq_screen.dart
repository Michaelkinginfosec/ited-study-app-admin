import 'package:flutter/material.dart';

class UploadPastTestQuestionScreen extends StatefulWidget {
  const UploadPastTestQuestionScreen({super.key});

  @override
  State<UploadPastTestQuestionScreen> createState() =>
      _UploadPastTestQuestionScreenState();
}

class _UploadPastTestQuestionScreenState
    extends State<UploadPastTestQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Upload Past Test Question Screen"),
      ),
    );
  }
}
