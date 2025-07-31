import 'package:flutter/material.dart';
import 'package:todo/presentation/pages/todo_list_page.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ToDoListPage());
  }
}
