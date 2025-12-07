import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String assignedTo;
  final int points;
  final bool isPrivate;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.assignedTo,
    required this.points,
    required this.isPrivate,
    this.dueDate,
    this.dueTime,
    this.isCompleted = false,
  });

  // Sample data
  static List<TaskModel> getSampleTasks() {
    return [
      TaskModel(
        id: "101",
        title: "Personal Note",
        description: "Private task",
        priority: "Medium Priority",
        assignedTo: "Evie Walton",
        points: 5,
        isPrivate: true,
        dueDate: DateTime(2025, 10, 19),
        dueTime: const TimeOfDay(hour: 18, minute: 47),
        isCompleted: true,
      ),
      TaskModel(
        id: "102",
        title: "Private Task",
        description: "Confidential",
        priority: "High Priority",
        assignedTo: "Evie Walton",
        points: 10,
        isPrivate: true,
        dueDate: DateTime(2025, 10, 20),
        dueTime: const TimeOfDay(hour: 14, minute: 30),
        isCompleted: true,
      ),
      TaskModel(
        id: "103",
        title: "New Task",
        description: "dddddd",
        priority: "Medium Priority",
        assignedTo: "Unassigned",
        points: 5,
        isPrivate: true,
        dueDate: DateTime(2025, 10, 21),
        dueTime: const TimeOfDay(hour: 18, minute: 47),
      ),
      TaskModel(
        id: "104",
        title: "Neww",
        description: "dddddd",
        priority: "Low Priority",
        assignedTo: "Evie Walton",
        points: 5,
        isPrivate: true,
        dueDate: DateTime(2025, 10, 22),
        dueTime: const TimeOfDay(hour: 14, minute: 30),
      ),
      TaskModel(
        id: "105",
        title: "Kitchen Cleanup",
        description: "Clean the kitchen after dinner",
        priority: "High Priority",
        assignedTo: "Emily Walton",
        points: 10,
        isPrivate: false,
        dueDate: DateTime(2025, 10, 20),
        dueTime: const TimeOfDay(hour: 20, minute: 0),
        isCompleted: true,
      ),
      TaskModel(
        id: "106",
        title: "Homework",
        description: "Complete math homework",
        priority: "Medium Priority",
        assignedTo: "Emily Walton",
        points: 15,
        isPrivate: false,
        dueDate: DateTime(2025, 10, 23),
        dueTime: const TimeOfDay(hour: 16, minute: 0),
      ),
    ];
  }
}

class TaskGroup {
  final String name;
  final String avatar;
  final List<TaskModel> tasks;
  bool isExpanded;

  TaskGroup({
    required this.name,
    required this.avatar,
    required this.tasks,
    this.isExpanded = false,
  });
}
