import 'package:flutter/material.dart';
import 'package:todo/application/app_colors.dart';
import 'package:todo/data/repository/todo_repository_impl.dart';
import 'package:todo/domain/model/task_status.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:todo/presentation/widgets/task_form.dart';
import 'package:todo/presentation/widgets/task_item.dart';
import 'package:uuid/uuid.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  static const _uuid = Uuid();

  final TodoRepository _repository = TodoRepositoryImpl();
  List<ToDo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todosList = await _repository.getAllTodos();

    setState(() {
      todos = todosList;
    });
  }

  Future<void> addTodo(String task, DateTime date) async {
    final trimmedTask = task.trim();

    if (trimmedTask.isEmpty) return;

    final newTodo = ToDo(
      id: _uuid.v4(),
      task: trimmedTask,
      date: date,
      status: TaskStatus.process,
    );

    await _repository.addTodo(newTodo);

    setState(() {
      todos.add(newTodo);
    });
  }

  Future<void> changeStatus(ToDo todo, int index) async {
    final newTodo = todo.copyWith(
      status: switch (todo.status) {
        TaskStatus.process => TaskStatus.done,
        TaskStatus.done => TaskStatus.process,
      },
    );

    await _repository.updateTodo(newTodo);

    setState(() {
      todos[index] = newTodo;
    });
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
