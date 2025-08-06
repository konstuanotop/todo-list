import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/dto/todo_dto.dart';
import 'package:todo/data/mapper/todo_mapper.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  static const _todosKey = 'todos';

  @override
  Future<List<ToDo>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_todosKey);

    if (jsonString == null) return [];

    final jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map(
          (json) => ToDoDto.fromJson(json as Map<String, dynamic>).toEntity(),
        )
        .toList();
  }

  @override
  Future<List<ToDo>> getTodoByTitle(String task) async {
    final todos = await getAll();
    return todos.where((todo) => todo.task == task).toList();
  }

  @override
  Future<void> addTodo(ToDo todo) async {
    final todos = await getAll();
    todos.add(todo);
    await _saveTodos(todos);
  }

  @override
  Future<void> updateTodo(ToDo updatedTodo) async {
    final todos = await getAll();
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index == -1) throw Exception('Задача не найдена');

    todos[index] = updatedTodo;
    await _saveTodos(todos);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await getAll();
    todos.removeWhere((todo) => todo.id == id);
    await _saveTodos(todos);
  }

  Future<void> _saveTodos(List<ToDo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = todos.map((todo) => todo.toDto().toJson()).toList();
    await prefs.setString(_todosKey, json.encode(jsonList));
  }
}
