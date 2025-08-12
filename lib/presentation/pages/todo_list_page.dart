import 'package:flutter/material.dart';
import 'package:todo/application/app_colors.dart';
import 'package:todo/presentation/controller/todos_controller.dart';
import 'package:todo/presentation/widgets/task_form.dart';
import 'package:todo/presentation/widgets/task_item.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({required this.controller, super.key});

  final TodosController controller;

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late final TodosController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.loadTodos();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                builder: (BuildContext context) =>
                    TaskForm(onAddTodo: _controller.addTodo),
              );
            },
            icon: const Icon(Icons.add, size: 36),
            color: AppColors.darkBlue,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return ListView.builder(
            itemCount: _controller.todos.length,
            itemBuilder: (context, index) {
              final todo = _controller.todos[index];
              return TaskItem(
                todo: todo,
                onChangeStatus: () => _controller.changeStatus(todo, index),
              );
            },
          );
        },
      ),
    );
  }
}
