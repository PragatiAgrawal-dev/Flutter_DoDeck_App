import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Choose Theme', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // You can actually change themes using setState or a ThemeProvider
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Light Theme selected')),
            );
          },
          child: const Text('Light Theme'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dark Theme selected')),
            );
          },
          child: const Text('Dark Theme'),
        ),
      ],
    );
  }
}
