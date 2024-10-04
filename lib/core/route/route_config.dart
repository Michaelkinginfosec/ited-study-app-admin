import 'package:go_router/go_router.dart';
import 'package:ited_study_app_admin/core/route/routes.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/presentation/views/upload_course_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_note/presentation/views/upload_note.dart';
import 'package:ited_study_app_admin/feature/admin/upload_note/presentation/views/upload_note_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_past_exam_question/presentation/views/upeq_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_past_test_question/presentation/views/uptq_screen.dart';
import 'package:ited_study_app_admin/feature/auth/presentation/views/login_screen.dart.dart';
import 'package:ited_study_app_admin/feature/auth/presentation/views/mobile.dart';

import '../../feature/auth/presentation/views/dashboard.dart';
import '../../feature/auth/presentation/views/responsive.dart';

final route = GoRouter(
  initialLocation: '/responsive',
  routes: [
    GoRoute(
      name: '/responsive',
      path: AdminRoutes.responsive,
      builder: (context, state) => const Responsive(
        desktop: AdminLoginScreen(),
        mobile: Mobile(),
      ),
    ),
    GoRoute(
      name: '/dashboard',
      path: AdminRoutes.dashboard,
      builder: (context, state) => Responsive(
        desktop: Dashboard(),
        mobile: Mobile(),
      ),
    ),
    GoRoute(
      name: '/mobile',
      path: AdminRoutes.mobile,
      builder: (context, state) => const Mobile(),
    ),
    GoRoute(
      name: '/uploadcourse',
      path: AdminRoutes.uploadcourse,
      builder: (context, state) => const Responsive(
        desktop: UploadCourseScreen(),
        mobile: Mobile(),
      ),
    ),
    GoRoute(
      name: '/uploadnote',
      path: AdminRoutes.uploadnote,
      builder: (context, state) => const Responsive(
        desktop: UploadNoteScreen(),
        mobile: Mobile(),
      ),
    ),
    GoRoute(
      name: '/uploadptq',
      path: AdminRoutes.uploadptq,
      builder: (context, state) => const Responsive(
        desktop: UploadPastTestQuestionScreen(),
        mobile: Mobile(),
      ),
    ),
    GoRoute(
      name: '/uploadpeq',
      path: AdminRoutes.uploadpeq,
      builder: (context, state) => const Responsive(
        desktop: UploadPastExamQuestionScreen(),
        mobile: Mobile(),
      ),
    ),
    GoRoute(
      name: '/login',
      path: AdminRoutes.login,
      builder: (context, state) => const Responsive(
        desktop: AdminLoginScreen(),
        mobile: Mobile(),
      ),
    ),
    GoRoute(
      name: '/note',
      path: AdminRoutes.note,
      builder: (context, state) => const Responsive(
        desktop: UploadNote(),
        mobile: Mobile(),
      ),
    )
  ],
);
