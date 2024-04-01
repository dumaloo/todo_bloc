import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/add_todo_screen.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';

class TodoListScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TodoListScreen({Key? key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(LoadTodos());
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return Dismissible(
                key: Key(todo.id.toString()), // Use todo's id as key
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  BlocProvider.of<TodoBloc>(context)
                      .add(DeleteTodo(todo: todo));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${todo.name} deleted'),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          BlocProvider.of<TodoBloc>(context)
                              .add(AddTodo(name: todo.name));
                        },
                      ),
                    ),
                  );
                },
                child: ListTile(
                  onTap: todo.isCompleted
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTodoScreen(
                                todo: todo,
                                isUpdating: true,
                              ),
                            ),
                          );
                        },
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      BlocProvider.of<TodoBloc>(context).add(
                        ToggleTodoCompletion(todo: todo, isCompleted: value!),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${todo.name} ${value ? 'completed' : 'incomplete'}',
                          ),
                          backgroundColor: value ? Colors.green : Colors.red,
                        ),
                      );
                    },
                  ),
                  title: Text(
                    todo.name,
                    style: TextStyle(
                      color: todo.isCompleted ? Colors.grey : Colors.white,
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(
                    'Created at: ${_formatDate(todo.createdAt)}',
                    style: TextStyle(
                      color: todo.isCompleted ? Colors.grey : Colors.white,
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-todo');
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
