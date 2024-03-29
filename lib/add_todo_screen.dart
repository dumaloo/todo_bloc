import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/models/todo_model.dart';

class AddTodoScreen extends StatefulWidget {
  final Todo? todo;
  final bool isUpdating;
  const AddTodoScreen({super.key, this.todo, this.isUpdating = false});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  late TextEditingController todoTitleController;

  @override
  void initState() {
    super.initState();
    todoTitleController = TextEditingController(text: widget.todo?.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.isUpdating ? 'Edit Todo' : 'Add Todo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: todoTitleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter todo title',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(16),
                    labelText: 'Title',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MaterialButton(
                onPressed: () {
                  // Check if the title is empty
                  if (todoTitleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Title is empty'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (widget.isUpdating) {
                    BlocProvider.of<TodoBloc>(context).add(EditTodo(
                      todo:
                          widget.todo!.copyWith(name: todoTitleController.text),
                    ));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Todo updated'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  } else {
                    BlocProvider.of<TodoBloc>(context).add(AddTodo(
                      name: todoTitleController.text,
                    ));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Todo added'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: Text(widget.isUpdating ? 'Update Todo' : 'Add Todo'),
              ),
            ],
          ),
        ));
  }
}
