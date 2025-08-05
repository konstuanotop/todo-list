import 'package:todo/domain/model/todo.dart';

abstract class TodoRepository {
  Future<List<ToDo>> getTodoByTitle(String task);

  Future<List<ToDo>> getAll();

  Future<void> addTodo(ToDo todo);

  Future<void> updateTodo(ToDo updatedTodo);

  Future<void> deleteTodo(String id);
}
