import 'package:todo/domain/model/task_status.dart';

class ToDo {
  ToDo({
    required this.id,
    required this.task,
    required this.date,
    required this.status,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
    id: json['id'] as String,
    task: json['task'] as String,
    date: DateTime.parse(json['date'] as String),
    status: TaskStatus.values.firstWhere((e) => e.toString() == json['status']),
  );

  final String id;
  final String task;
  final DateTime date;
  final TaskStatus status;

  Map<String, dynamic> toJson() => {
    'id': id,
    'task': task,
    'date': date.toIso8601String(),
    'status': status.toString(),
  };

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
