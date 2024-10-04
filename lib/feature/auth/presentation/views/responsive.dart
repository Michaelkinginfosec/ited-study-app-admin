// ignore_for_file: prefer_const_constructors, avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:ited_study_app_admin/feature/auth/presentation/views/mobile.dart';

class Responsive extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;
  const Responsive({super.key, required this.desktop, required this.mobile});

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
        if (constraints.maxWidth < 1100 || isMobileDevice()) {
          return Mobile();
        } else {
          return desktop;
        }
      },
    );
  }
}
