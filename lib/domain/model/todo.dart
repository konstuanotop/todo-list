import 'package:todo/domain/model/task_status.dart';

class ToDo {
  ToDo({
    required this.id,
    required this.task,
    required this.date,
    required this.status,
  });

  final String id;
  final String task;
  final DateTime date;
  final TaskStatus status;

  ToDo copyWith({
    String? id,
    String? task,
    DateTime? date,
    TaskStatus? status,
  }) {
    return ToDo(
      id: id ?? this.id,
      task: task ?? this.task,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
