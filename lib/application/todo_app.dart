import 'package:flutter/material.dart';
import 'package:todo/data/repository/todo_repository_impl.dart';
import 'package:todo/presentation/controller/todos_controller.dart';
import 'package:todo/presentation/pages/todo_list_page.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final controller = TodosController(repository: TodoRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoListPage(
        controller: controller,
      ),
    );
  }
}
