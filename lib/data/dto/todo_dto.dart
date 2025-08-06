class ToDoDto {
  ToDoDto({
    required this.id,
    required this.task,
    required this.date,
    required this.status,
  });

  factory ToDoDto.fromJson(Map<String, dynamic> json) => ToDoDto(
    id: json['id'] as String,
    task: json['task'] as String,
    date: json['date'] as String,
    status: json['status'] as String,
  );

  final String id;
  final String task;
  final String date;
  final String status;

  Map<String, dynamic> toJson() => {
    'id': id,
    'task': task,
    'date': date,
    'status': status,
  };
}
