import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/password_entry.dart';
import 'dart:math';

class PasswordDetailScreen extends StatefulWidget {
  final PasswordEntry? passwordEntry;

  const PasswordDetailScreen({super.key, this.passwordEntry});

  @override
  State<PasswordDetailScreen> createState() => _PasswordDetailScreenState();
}

class _PasswordDetailScreenState extends State<PasswordDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _websiteController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _isNewEntry = true;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _isNewEntry = widget.passwordEntry == null;
    _websiteController = TextEditingController(text: widget.passwordEntry?.website ?? '');
    _usernameController = TextEditingController(text: widget.passwordEntry?.username ?? '');
    _passwordController = TextEditingController(text: widget.passwordEntry?.password ?? '');
  }

  @override
  void dispose() {
    _websiteController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newEntry = PasswordEntry(
        id: widget.passwordEntry?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        website: _websiteController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).pop(newEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNewEntry ? 'Add Password' : 'Edit Password'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
            tooltip: 'Save',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(
                  labelText: 'Website / Service',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.language),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a website or service name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username / Email',
                  border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username or email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
