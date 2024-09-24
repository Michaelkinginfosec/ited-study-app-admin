// ignore_for_file: prefer_const_constructors, avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:ited_study_app_admin/feature/auth/presentation/views/text_mobile.dart';

class Responsive extends StatelessWidget {
  final Widget desktop;
  const Responsive({
    super.key,
    required this.desktop,
  });

  bool isMobileDevice() {
    final userAgent = html.window.navigator.userAgent.toLowerCase();

    return userAgent.contains('iphone') ||
        userAgent.contains('android') ||
        userAgent.contains('ipad') ||
        userAgent.contains('mobile');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600 || isMobileDevice()) {
          return TextMobile();
        } else {
          return desktop;
        }
      },
    );
  }
}
