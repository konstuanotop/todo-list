import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/presentation/controller/todos_controller.dart';
import 'package:todo/presentation/widgets/task_form.dart';
import 'package:todo/presentation/widgets/task_item.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({required this.controller, super.key});

  final TodosController controller;

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late final TodosController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.loadTodos();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<TaskForm>(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                builder: (BuildContext context) =>
                    TaskForm(onAddTodo: _controller.addTodo),
              );
            },
            icon: const Icon(Icons.add, size: 36),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return SlidableAutoCloseBehavior(
            child: ListView.builder(
              itemCount: _controller.todos.length,
              itemBuilder: (context, index) {
                final todo = _controller.sortedTodos[index];

                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Slidable(
                      key: ValueKey(todo.id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Удалить окончательно?'),
                                    content: Text(todo.task),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _controller.deleteTodo(
                                            todo.id,
                                            todo.task,
                                          );
                                          Navigator.of(context).pop(true);
                                        },
                                        child: const Text('Да'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text('Нет'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.tertiary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onTertiary,
                            icon: Icons.delete,
                            label: 'Удалить',
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          SlidableAction(
                            onPressed: (_) {
                              showModalBottomSheet<TaskForm>(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                ),
                                builder: (BuildContext context) => TaskForm(
                                  onUpdateTodo: _controller.updateTodo,
                                  id: todo.id,
                                  task: todo.task,
                                  date: todo.date,
                                  status: todo.status,
                                ),
                              );
                            },
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                            icon: Icons.edit,
                            label: 'Изменить',
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                      child: TaskItem(
                        todo: todo,
                        onChangeStatus: () => _controller.changeStatus(todo),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
