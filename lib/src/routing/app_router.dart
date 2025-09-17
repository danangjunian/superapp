import 'package:go_router/go_router.dart';

import '../ui/shell/app_shell.dart';
import '../ui/pages/auth/onboarding_page.dart';
import '../ui/pages/auth/signin_page.dart';
import '../ui/pages/dashboard/home_page.dart';
import '../ui/pages/attendance/attendance_page.dart';
import '../ui/pages/exams/exams_page.dart';
import '../ui/pages/assignments/assignments_page.dart';
import '../ui/pages/grades/grades_page.dart';
import '../ui/pages/announcements/announcements_page.dart';
import '../ui/pages/calendar/schedule_page.dart';
import '../ui/pages/chat/chat_page.dart';
import '../ui/pages/profile/profile_page.dart';
import '../ui/pages/settings/settings_page.dart';

/// Builds a GoRouter configuration for the app.
GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),
      GoRoute(path: '/signin', builder: (_, __) => const SignInPage()),
      // Shell for bottom navigation pages
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) => AppShell(navShell: navShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomePage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/attendance', builder: (_, __) => const AttendancePage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/exams', builder: (_, __) => const ExamsPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/assignments', builder: (_, __) => const AssignmentsPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/grades', builder: (_, __) => const GradesPage()),
          ]),
        ],
      ),
      GoRoute(path: '/announcements', builder: (_, __) => const AnnouncementsPage()),
      GoRoute(path: '/schedule', builder: (_, __) => const SchedulePage()),
      GoRoute(path: '/chat', builder: (_, __) => const ChatPage()),
      GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
    ],
  );
}
