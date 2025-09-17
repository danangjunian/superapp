import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Sign in screen with email and password fields.
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 12),
            Text('Masuk', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 8),
            Text('Gunakan akun sekolah Anda untuk melanjutkan.',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email sekolah'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Kata sandi',
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/home'), // stub for sign in
              child: const Text('Masuk'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Lupa kata sandi?'),
            ),
          ],
        ),
      ),
    );
  }
}
