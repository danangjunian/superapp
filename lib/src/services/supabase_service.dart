import 'package:supabase_flutter/supabase_flutter.dart';

/// Encapsulates Supabase initialization and exposes the client.
class SupabaseService {
  /// Supabase project URL and anon key for the `superapp` project.
  ///
  /// These values are read from the user's supplied credentials. The URL is
  /// constructed from the Supabase project ref (decoded from the provided JWT)
  /// and follows the pattern `https://<ref>.supabase.co`. The anon key allows
  /// unauthenticated access for clientâ€‘side operations. If you create a new
  /// Supabase project, remember to update these values accordingly.
  static const _supabaseUrl = 'https://ebumeriqbejqaifcmyuk.supabase.co';
  static const _supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVidW1lcmlxYmVqcWFpZmNteXVrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgwODc2NzEsImV4cCI6MjA3MzY2MzY3MX0.m0dRBxT7MsmezyyRo53gnb1XLXWVJ1AcgSPDgnMAqEo';

  /// Initializes the Supabase client. Call this before using the client.
  static Future<void> initialize() async {
    await Supabase.initialize(url: _supabaseUrl, anonKey: _supabaseKey);
  }

  /// Provides access to the Supabase client.
  static SupabaseClient get client => Supabase.instance.client;
}
