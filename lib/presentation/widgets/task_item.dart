import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/model/todo.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({required this.todo, required this.onChangeStatus, super.key});

  final ToDo todo;
  final VoidCallback onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: todo.status.isProcces
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      todo.task,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        decoration: todo.status.isProcces
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
                        decorationThickness: 2,
                        color: todo.status.isProcces
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('dd.MM.yyyy').format(todo.date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: todo.status.isProcces
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onPrimary,
                        decoration: todo.status.isProcces
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onChangeStatus,
                icon: todo.status.isProcces
                    ? const Icon(Icons.circle_outlined)
                    : Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
