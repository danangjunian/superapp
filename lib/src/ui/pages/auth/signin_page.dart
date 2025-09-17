import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _busy = false;
  bool _obscure = true;
  bool _valid = false;

  @override
  void initState() {
    super.initState();
    _email.addListener(_revalidate);
    _password.addListener(_revalidate);
  }

  void _revalidate() {
    final nowValid = _formKey.currentState?.validate() ?? false;
    if (nowValid != _valid) setState(() => _valid = nowValid);
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
    final r = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!r.hasMatch(v.trim())) return 'Format email tidak valid';
    return null;
  }

  String? _passValidator(String? v) {
    if (v == null || v.isEmpty) return 'Kata sandi wajib diisi';
    if (v.length < 5) return 'Minimal 5 karakter';
    return null;
  }

  Future<void> _signIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() => _busy = true);
    try {
      await SupabaseService.client.auth.signInWithPassword(
        email: _email.text.trim(),
        password: _password.text,
      );
      // Tidak perlu push route manual — GoRouter redirect akan kirim ke /home ketika user != null
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal: ${e.message}')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login gagal. Coba lagi.')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = SupabaseService.client.auth.currentUser;

    // Jika sudah login (sesi tersimpan), tampilkan info & opsi keluar
    if (user != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Masuk')),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Kamu sudah login.'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                await SupabaseService.client.auth.signOut();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil keluar')),
                );
                setState(() {}); // refresh tampilan
              },
              child: const Text('Keluar akun'),
            ),
          ]),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Masuk')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email sekolah'),
              validator: _emailValidator,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Kata sandi',
                suffixIcon: IconButton(
                  icon: Icon(_obscure
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              validator: _passValidator,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: (_valid && !_busy) ? _signIn : null,
              child: _busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}
