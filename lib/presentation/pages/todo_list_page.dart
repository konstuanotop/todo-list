import 'package:flutter/material.dart';
import 'package:todo/application/app_colors.dart';
import 'package:todo/domain/model/task_status.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/presentation/widgets/task_form.dart';
import 'package:todo/presentation/widgets/task_item.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<ToDo> todos = [];

  void addTodo(String task, DateTime date) {
    final trimmedTask = task.trim();

    if (trimmedTask.isEmpty) return;

    setState(() {
      todos.add(
        ToDo(task: trimmedTask, date: date, status: TaskStatus.process),
      );
    });
  }

  void changeStatus(ToDo todo, int index) {
    final newTodo = todo.copyWith(
      status: switch (todo.status) {
        TaskStatus.process => TaskStatus.done,
        TaskStatus.done => TaskStatus.process,
      },
    );

    todos[index] = newTodo;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Tasks',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppColors.white,
        shadowColor: AppColors.black,
        elevation: 4,
        scrolledUnderElevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<TaskForm>(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                builder: (BuildContext context) => TaskForm(onAddTodo: addTodo),
              );
            },
            icon: const Icon(Icons.add, size: 36),
            color: AppColors.darkBlue,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TaskItem(
            todo: todo,
            onChangeStatus: () => changeStatus(todo, index),
          );
        },
      ),
    );
  }
}
