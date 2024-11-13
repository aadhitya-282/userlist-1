import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_list_app/user_provider.dart';
import 'user.dart';

class UserListScreen extends ConsumerStatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => setState(() => searchQuery = value),
          decoration: InputDecoration(
            hintText: 'Search users...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: userAsyncValue.when(
        data: (users) {
          final filteredUsers = users
              .where((user) => user.name.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();
          return RefreshIndicator(
            onRefresh: () async => ref.refresh(userProvider),
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load users')),
      ),
    );
  }
}
