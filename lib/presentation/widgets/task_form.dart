import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key, required this.onAddTodo});

  final Function(String, String) onAddTodo;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _controllerTask = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  DateTime? _selectedDate;
  DateTime? _lastSelectedDate;

  @override
  void dispose() {
    _controllerTask.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

  bool _submitted = false;

  String? get _errorText {
    final text = _controllerTask.text.trim();

    if (text.isEmpty && _submitted) {
      return 'Поле задачи пусто';
    }

    return null;
  }

  String? get _errorDate {
    final date = _controllerDate.text;

    if (date.isEmpty) {
      return 'Поле срока задачи пусто';
    }
    return null;
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _lastSelectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );

    DateFormat dateFormat = DateFormat("dd.MM.yyyy");

    if (pickedDate != null && pickedDate != _lastSelectedDate) {
      setState(() {
        _lastSelectedDate = pickedDate;
        _selectedDate = pickedDate;
        _controllerDate.text = dateFormat.format(_selectedDate!);
      });
    }
  }

  void _submit() {
    setState(() {
      _submitted = true;
    });

    if (_controllerTask.text.trim().isNotEmpty && _selectedDate != null) {
      widget.onAddTodo(_controllerTask.text, _controllerDate.text);
      Navigator.pop(context);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Введите название задачи:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 70,
                child: TextFormField(
                  controller: _controllerTask,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Название задачи',
                    errorText: _errorText,
                    counterText: '',
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Поле задач пусто';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    if (_submitted) {
                      setState(() {});
                    }
                  },
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Выберите срок выполнения задачи',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 70,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Крайний срок',
                    errorText: _submitted ? _errorDate : null,
                  ),
                  controller: _controllerDate,
                  readOnly: true,
                  onTap: _selectDate,
                ),
              ),
            ],
          ),
          SizedBox(height: 35),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 162, 149, 213),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: _submit,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: const Text(
                    'Создать задачу',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
        ],
      ),
    );
  }
}
