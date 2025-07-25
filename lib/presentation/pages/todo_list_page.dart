import 'package:flutter/material.dart';
import 'package:todo/domain/model/task_status.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/presentation/widgets/task_item.dart';
import 'package:todo/presentation/widgets/task_form.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<ToDo> todos = [];

  void addTodo(String task, String date) {
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
      status: (switch (todo.status) {
        TaskStatus.process => TaskStatus.done,
        TaskStatus.done => TaskStatus.process,
      }),
    );

    todos[index] = newTodo;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Tasks',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 4,
        scrolledUnderElevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                builder: (BuildContext context) => TaskForm(onAddTodo: addTodo),
              );
            },
            icon: Icon(Icons.add, size: 36),
            color: const Color.fromARGB(255, 8, 73, 127),
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
