import 'package:todo/data/dto/todo_dto.dart';
import 'package:todo/domain/model/task_status.dart';
import 'package:todo/domain/model/todo.dart';

extension ToDoMapper on ToDo {
  ToDoDto toDto() {
    return ToDoDto(
      id: id,
      task: task,
      date: date.toIso8601String(),
      status: status.toString(),
    );
  }
}

extension ToDoDtoMapper on ToDoDto {
  ToDo toEntity() {
    return ToDo(
      id: id,
      task: task,
      date: DateTime.parse(date),
      status: TaskStatus.values.firstWhere((e) => e.toString() == status),
    );
  }
}
