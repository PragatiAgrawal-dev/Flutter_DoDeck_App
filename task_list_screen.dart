import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return ListView.builder(
      itemCount: provider.tasks.length,
      itemBuilder: (context, index) {
        final task = provider.tasks[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          elevation: 3,
          child: ListTile(
            title: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.description),
                const SizedBox(height: 8),
                _buildProgressSlider(context, task, provider),
              ],
            ),
            trailing: Wrap(
              spacing: 12,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _showEditDialog(context, task, provider);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    provider.deleteTask(task.id!);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressSlider(
    BuildContext context,
    Task task,
    TaskProvider provider,
  ) {
    int getStatusIndex(String status) {
      switch (status) {
        case 'Not Started':
          return 0;
        case 'In Progress':
          return 1;
        case 'Completed':
          return 2;
        default:
          return 0;
      }
    }

    String getStatusFromIndex(int index) {
      switch (index) {
        case 0:
          return 'Not Started';
        case 1:
          return 'In Progress';
        case 2:
          return 'Completed';
        default:
          return 'Not Started';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Slider(
          value: getStatusIndex(task.status).toDouble(),
          min: 0,
          max: 2,
          divisions: 2,
          label: task.status,
          onChanged: (value) {
            final newStatus = getStatusFromIndex(value.toInt());
            provider.updateTask(
              Task(
                id: task.id,
                title: task.title,
                description: task.description,
                status: newStatus,
                dueDate: task.dueDate,
              ),
            );
          },
        ),
        Text('Status: ${task.status}'),
      ],
    );
  }

  void _showEditDialog(BuildContext context, Task task, TaskProvider provider) {
    TextEditingController titleController = TextEditingController(
      text: task.title,
    );
    TextEditingController descController = TextEditingController(
      text: task.description,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                provider.updateTask(
                  Task(
                    id: task.id,
                    title: titleController.text,
                    description: descController.text,
                    status: task.status,
                    dueDate: task.dueDate,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
