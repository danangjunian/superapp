import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:superapp/src/services/supabase_service.dart';

// Pakai package import supaya stabil terhadap perubahan struktur folder
import 'package:superapp/src/ui/shell/app_shell.dart';
import 'package:superapp/src/ui/pages/auth/onboarding_page.dart';
import 'package:superapp/src/ui/pages/auth/signin_page.dart';
import 'package:superapp/src/ui/pages/dashboard/home_page.dart';
import 'package:superapp/src/ui/pages/attendance/attendance_page.dart'; // <-- halaman Absensi utama
import 'package:superapp/src/ui/pages/attendance/scan_page.dart'; // <-- halaman Scanner
import 'package:superapp/src/ui/pages/exams/exams_page.dart';
import 'package:superapp/src/ui/pages/assignments/assignments_page.dart';
import 'package:superapp/src/ui/pages/grades/grades_page.dart';
import 'package:superapp/src/ui/pages/announcements/announcements_page.dart';
import 'package:superapp/src/ui/pages/calendar/schedule_page.dart';
import 'package:superapp/src/ui/pages/chat/chat_page.dart';
import 'package:superapp/src/ui/pages/profile/profile_page.dart';
import 'package:superapp/src/ui/pages/settings/settings_page.dart';

/// Helper agar GoRouter refresh ketika status auth berubah (login/logout).
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final StreamSubscription _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

/// Builds a GoRouter configuration for the app.
GoRouter buildRouter() {
  final refresh = GoRouterRefreshStream(
    SupabaseService.client.auth.onAuthStateChange,
  );

  return GoRouter(
    debugLogDiagnostics: false, // set true jika mau log routing
    initialLocation: '/onboarding',
    refreshListenable: refresh,
    redirect: (context, state) {
      final loggedIn = SupabaseService.client.auth.currentUser != null;
      final isAuthPage = state.matchedLocation == '/signin' ||
          state.matchedLocation == '/onboarding';

      if (!loggedIn && !isAuthPage)
        return '/signin'; // belum login -> paksa ke signin
      if (loggedIn && isAuthPage)
        return '/home'; // sudah login -> jangan di layar auth
      return null;
    },
    routes: [
      // Halaman auth
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),
      GoRoute(path: '/signin', builder: (_, __) => const SignInPage()),

      // Shell untuk bottom navigation (5 tab)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) => AppShell(navShell: navShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomePage()),
          ]),
          StatefulShellBranch(routes: [
            // <-- perbaikan: route TAB Absensi harus ke AttendancePage
            GoRoute(
                path: '/attendance',
                builder: (_, __) => const AttendancePage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/exams', builder: (_, __) => const ExamsPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/assignments',
                builder: (_, __) => const AssignmentsPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/grades', builder: (_, __) => const GradesPage()),
          ]),
        ],
      ),

      // Halaman di luar bottom nav (standalone pages)
      // Scanner JANGAN diletakkan di branch tab, supaya buka sebagai layar terpisah
      GoRoute(
          path: '/attendance/scan',
          builder: (_, __) => const AttendanceScanPage()),
      GoRoute(
          path: '/announcements',
          builder: (_, __) => const AnnouncementsPage()),
      GoRoute(path: '/schedule', builder: (_, __) => const SchedulePage()),
      GoRoute(path: '/chat', builder: (_, __) => const ChatPage()),
      GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
    ],
  );
}
