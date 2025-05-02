import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Task Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Task Description'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final task = Task(
                title: _titleController.text,
                description: _descriptionController.text,
                status: 'Not Started',
                dueDate: DateTime.now(),
              );
              Provider.of<TaskProvider>(context, listen: false).addTask(task);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Task Added!')));
              _titleController.clear();
              _descriptionController.clear();
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
