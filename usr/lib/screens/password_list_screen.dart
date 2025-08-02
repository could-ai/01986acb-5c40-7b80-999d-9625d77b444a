import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/password_entry.dart';
import 'package:couldai_user_app/screens/password_detail_screen.dart';
import 'package:couldai_user_app/widgets/password_list_item.dart';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  final List<PasswordEntry> _passwordEntries = [
    PasswordEntry(id: '1', website: 'Google', username: 'user@gmail.com', password: 'password123'),
    PasswordEntry(id: '2', website: 'Facebook', username: 'user@facebook.com', password: 'password456'),
    PasswordEntry(id: '3', website: 'Twitter', username: 'user@twitter.com', password: 'password789'),
  ];

  void _addOrUpdatePassword(PasswordEntry entry) {
    final index = _passwordEntries.indexWhere((e) => e.id == entry.id);
    setState(() {
      if (index != -1) {
        _passwordEntries[index] = entry;
      } else {
        _passwordEntries.add(entry);
      }
    });
  }

  void _deletePassword(String id) {
    setState(() {
      _passwordEntries.removeWhere((entry) => entry.id == id);
    });
  }

  void _navigateAndEdit(PasswordEntry? entry) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordDetailScreen(passwordEntry: entry),
      ),
    );

    if (result != null && result is PasswordEntry) {
      _addOrUpdatePassword(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Manager'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: _passwordEntries.isEmpty
          ? const Center(
              child: Text(
                'No passwords saved.\nTap the + button to add one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _passwordEntries.length,
              itemBuilder: (context, index) {
                final entry = _passwordEntries[index];
                return PasswordListItem(
                  entry: entry,
                  onTap: () => _navigateAndEdit(entry),
                  onDelete: () => _deletePassword(entry.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndEdit(null),
        tooltip: 'Add Password',
        child: const Icon(Icons.add),
      ),
    );
  }
}
