import 'package:go_router/go_router.dart';
import 'package:ited_study_app_admin/core/route/routes.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/presentation/views/upload_course_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_note/presentation/views/upload_note.dart';
import 'package:ited_study_app_admin/feature/admin/upload_note/presentation/views/upload_note_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_past_exam_question/presentation/views/upeq_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_past_test_question/presentation/views/uptq_screen.dart';
import 'package:ited_study_app_admin/feature/auth/presentation/views/login_screen.dart.dart';

import '../../feature/auth/presentation/views/dashboard.dart';
import '../../feature/auth/presentation/views/responsive.dart';

final route = GoRouter(
  initialLocation: '/responsive',
  routes: [
    GoRoute(
      name: '/responsive',
      path: AdminRoutes.responsive,
      builder: (context, state) => const Responsive(
        desktop: Dashboard(),
      ),
    ),
    GoRoute(
      name: '/dashboard',
      path: AdminRoutes.dashboard,
      builder: (context, state) => const Dashboard(),
    ),
    GoRoute(
      name: '/uploadcourse',
      path: AdminRoutes.uploadcourse,
      builder: (context, state) => const UploadCourseScreen(),
    ),
    GoRoute(
      name: '/uploadnote',
      path: AdminRoutes.uploadnote,
      builder: (context, state) => const UploadNoteScreen(),
    ),
    GoRoute(
      name: '/uploadptq',
      path: AdminRoutes.uploadptq,
      builder: (context, state) => const UploadPastTestQuestionScreen(),
    ),
    GoRoute(
      name: '/uploadpeq',
      path: AdminRoutes.uploadpeq,
      builder: (context, state) => const UploadPastExamQuestionScreen(),
    ),
    GoRoute(
      name: '/login',
      path: AdminRoutes.login,
      builder: (context, state) => const AdminLoginScreen(),
    ),
    GoRoute(
      name: '/note',
      path: AdminRoutes.note,
      builder: (context, state) => const UploadNote(),
    )
  ],
);
