import 'package:flutter/material.dart';
import 'package:todo/domain/model/task_status.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:uuid/uuid.dart';

class TodosController extends ChangeNotifier {
  TodosController({required TodoRepository repository})
    : _repository = repository;

  static const _uuid = Uuid();
  final TodoRepository _repository;
  List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;

  Future<void> loadTodos() async {
    final todosList = await _repository.getAll();

    _todos = todosList;

    notifyListeners();
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

    _todos.add(newTodo);

    notifyListeners();
  }

  Future<void> changeStatus(ToDo todo, int index) async {
    final newTodo = todo.copyWith(
      status: switch (todo.status) {
        TaskStatus.process => TaskStatus.done,
        TaskStatus.done => TaskStatus.process,
      },
    );

    await _repository.updateTodo(newTodo);

    _todos[index] = newTodo;

    notifyListeners();
  }
}
