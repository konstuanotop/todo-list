import 'package:flutter/material.dart';
import 'package:todo/domain/model/task_status.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:uuid/uuid.dart';

class TodosController extends ChangeNotifier {
  TodosController({required TodoRepository repository})
    : _repository = repository;

  final TodoRepository _repository;

  static const _uuid = Uuid();

  List<ToDo> _todos = [];
  List<ToDo> get todos => _todos;

  int _findIndexById(String id) {
    return _todos.indexWhere((todo) => todo.id == id);
  }

  Future<void> loadTodos() async {
    _todos = await _repository.getAll();

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

  Future<void> changeStatus(ToDo todo) async {
    final newTodo = todo.copyWith(
      status: switch (todo.status) {
        TaskStatus.process => TaskStatus.done,
        TaskStatus.done => TaskStatus.process,
      },
    );

    await _repository.updateTodo(newTodo);

    final index = _findIndexById(todo.id);
    if (index != -1) {
      _todos[index] = newTodo;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(String id, String task) async {
    await _repository.deleteTodo(id);
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  Future<void> updateTodo(ToDo updatedTodo) async {
    final index = _findIndexById(updatedTodo.id);

    if (index == -1) {
      throw Exception('Задача ${updatedTodo.task} не найдена');
    }

    await _repository.updateTodo(updatedTodo);

    _todos[index] = updatedTodo;

    notifyListeners();
  }

  List<ToDo> get sortedTodos {
    return [..._todos]
      ..sort((a, b) => a.date.compareTo(b.date))
      ..sort((a, b) => a.status.index.compareTo(b.status.index));
  }
}
