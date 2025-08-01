import 'package:todo/domain/model/todo.dart';

abstract class TodoRepository {
  Future<List<ToDo>> getTodoByTask(String task);

  Future<List<ToDo>> getAllTodos();

  Future<void> addTodo(ToDo todo);

  Future<void> saveTodos(List<ToDo> todos);

  Future<void> updateTodo(ToDo updatedTodo);

  Future<void> deleteTodo(String id);
}
