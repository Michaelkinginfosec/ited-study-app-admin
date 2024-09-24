import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class UploadNote extends StatefulWidget {
  const UploadNote({super.key});

  @override
  State<UploadNote> createState() => _UploadNoteState();
}

QuillController _controller = QuillController.basic();

class _UploadNoteState extends State<UploadNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          QuillToolbar.simple(
            controller: _controller,
            configurations: QuillSimpleToolbarConfigurations(
              embedButtons: FlutterQuillEmbeds.toolbarButtons(),
            ),
          ),
          Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              configurations: QuillEditorConfigurations(
                placeholder: "Write a notes",
                embedBuilders: kIsWeb
                    ? FlutterQuillEmbeds.editorWebBuilders()
                    : FlutterQuillEmbeds.editorBuilders(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
