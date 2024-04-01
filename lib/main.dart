import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/add_todo_screen.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:todo_bloc/todo_list_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter()); // Register Hive adapter
  await Hive.openBox<Todo>('todolist'); // Open Hive box for todos
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => const TodoListScreen(),
          '/add-todo': (context) => const AddTodoScreen(),
        },
      ),
    );
  }
}
