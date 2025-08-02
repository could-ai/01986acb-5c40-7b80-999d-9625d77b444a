import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/password_entry.dart';

class PasswordListItem extends StatelessWidget {
  final PasswordEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PasswordListItem({
    super.key,
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(entry.website[0].toUpperCase()),
        ),
        title: Text(entry.website),
        subtitle: Text(entry.username),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Confirm Deletion'),
                content: Text('Are you sure you want to delete the password for ${entry.website}?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      onDelete();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        onTap: onTap,
      ),
    );
  }
}
