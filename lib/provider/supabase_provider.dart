import 'package:encrypt/encrypt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = StateProvider((ref) => Supabase.instance.client);
final encrypterProvider = StateProvider<Encrypter?>((ref) => null);
