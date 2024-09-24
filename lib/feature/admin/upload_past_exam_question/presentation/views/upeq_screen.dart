import 'package:flutter/material.dart';

class UploadPastExamQuestionScreen extends StatefulWidget {
  const UploadPastExamQuestionScreen({super.key});

  @override
  State<UploadPastExamQuestionScreen> createState() =>
      _UploadPastExamQuestionScreebState();
}

class _UploadPastExamQuestionScreebState
    extends State<UploadPastExamQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Upload Past Exam Question Screen"),
      ),
    );
  }
}
