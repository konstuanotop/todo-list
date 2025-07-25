import 'package:todo/domain/model/task_status.dart';

class ToDo {
  final String task;
  final String date;
  final TaskStatus status;

  const ToDo({required this.task, required this.date, required this.status});

  @override
  String toString() {
    return 'ToDo(task: $task, date: $date, status: $status)';
  }

  ToDo copyWith({String? task, String? date, TaskStatus? status}) {
    return ToDo(
      task: task ?? this.task,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
