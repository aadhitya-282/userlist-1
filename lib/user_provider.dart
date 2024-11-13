import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user.dart';
import 'api_service.dart';
final userProvider = FutureProvider<List<User>> ((ref) async {
  return ApiService().fetchUsers();
});