import 'package:todo/domain/model/task_status.dart';

class ToDo {
  const ToDo({
    required this.task,
    required this.date,
    required this.status,
  });

  final String task;
  final DateTime date;
  final TaskStatus status;

  ToDo copyWith({String? task, DateTime? date, TaskStatus? status}) {
    return ToDo(
      task: task ?? this.task,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
