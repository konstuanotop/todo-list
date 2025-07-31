import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/application/app_colors.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({required this.onAddTodo, super.key});

  final void Function(String taskName, DateTime taskDate) onAddTodo;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _controllerTask = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  DateTime? _selectedDate;

  String? _errorTextTask;
  String? _errorTextDate;

  @override
  void dispose() {
    _controllerTask.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

  void _validateText(String? text) {
    final initialErrorText = _errorTextTask;

    if (text == null || text.trim().isEmpty) {
      _errorTextTask = 'Поле задачи пусто';
    } else {
      _errorTextTask = null;
    }

    if (initialErrorText != _errorTextTask) setState(() {});
  }

  void _validateDate() {
    if (_selectedDate == null) {
      _errorTextDate = 'Поле срока задачи пусто';
    } else {
      _errorTextDate = null;
    }
    setState(() {});
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _controllerDate.text = DateFormat('dd.MM.yyyy').format(_selectedDate!);

        _validateDate();
      });
    }
  }

  void _submit() {
    _validateText(_controllerTask.text);
    _validateDate();

    if (_controllerTask.text.trim().isNotEmpty && _selectedDate != null) {
      widget.onAddTodo(_controllerTask.text, _selectedDate!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Введите название задачи:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 70,
                child: TextField(
                  controller: _controllerTask,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Название задачи',
                    errorText: _errorTextTask,
                    counterText: '',
                  ),
                  onChanged: _validateText,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Выберите срок выполнения задачи',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 70,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Крайний срок',
                    errorText: _errorTextDate,
                  ),
                  controller: _controllerDate,
                  readOnly: true,
                  onTap: _selectDate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.palePurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: _submit,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Создать задачу',
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
