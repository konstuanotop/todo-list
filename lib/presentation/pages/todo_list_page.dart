import 'package:flutter/material.dart';
import 'package:todo/application/app_colors.dart';
import 'package:todo/presentation/providers/todos_provider.dart';
import 'package:todo/presentation/widgets/task_form.dart';
import 'package:todo/presentation/widgets/task_item.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late final TodosController controller;

  @override
  void initState() {
    super.initState();
    controller = TodosController();
    controller.loadTodos();
  }

  @override
  void dispose() {
    controller.dispose();
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
                    TaskForm(onAddTodo: controller.addTodo),
              );
            },
            icon: const Icon(Icons.add, size: 36),
            color: AppColors.darkBlue,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return ListView.builder(
            itemCount: controller.todos.length,
            itemBuilder: (context, index) {
              final todo = controller.todos[index];
              return TaskItem(
                todo: todo,
                onChangeStatus: () => controller.changeStatus(todo, index),
              );
            },
          );
        },
      ),
    );
  }
}
