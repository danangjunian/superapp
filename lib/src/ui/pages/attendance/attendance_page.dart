import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absensi')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => context.go('/attendance/scan'),
          icon: const Icon(Icons.qr_code_scanner_rounded),
          label: const Text('Mulai Scan'),
        ),
      ),
    );
  }
}
