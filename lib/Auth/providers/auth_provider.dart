import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_api.dart';
import 'dio_provider.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.read(dioProvider);
  return AuthApi(dio);
});

