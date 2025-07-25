import 'package:flutter/material.dart';
import 'package:todo/domain/model/todo.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.todo, required this.onChangeStatus});

  final ToDo todo;
  final VoidCallback onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: todo.status.isProcces
              ? const Color.fromARGB(255, 182, 174, 214)
              : const Color.fromARGB(255, 101, 100, 105),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      todo.task,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        decoration: todo.status.isProcces
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
                        decorationThickness: 2,
                        color: todo.status.isProcces
                            ? Colors.black
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 8),
                    Text(
                      todo.date,
                      style: TextStyle(
                        color: todo.status.isProcces
                            ? Colors.black
                            : Colors.white,
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
                    ? Icon(Icons.circle_outlined)
                    : Icon(Icons.check, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
