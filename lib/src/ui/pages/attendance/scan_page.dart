import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../services/supabase_service.dart';

class AttendanceScanPage extends StatefulWidget {
  const AttendanceScanPage({super.key});
  @override
  State<AttendanceScanPage> createState() => _AttendanceScanPageState();
}

class _AttendanceScanPageState extends State<AttendanceScanPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _busy = false;

  Future<void> _mark(String token) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await SupabaseService.client
          .rpc('mark_attendance', params: {'p_token': token});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Absensi berhasil')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal absen: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Absensi')),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final code = barcodes.first.rawValue;
                if (code != null && code.isNotEmpty) _mark(code);
              }
            },
            errorBuilder: (context, error, child) {
              if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.no_photography_rounded, size: 48),
                      const SizedBox(height: 8),
                      const Text(
                          'Izin kamera ditolak. Aktifkan di Pengaturan.'),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () async {
                          await _controller.start();
                          setState(() {});
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: Text(
                    'Kamera error: ${error.errorDetails ?? error.errorCode.name}'),
              );
            },
          ),
          if (_busy)
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: LinearProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
