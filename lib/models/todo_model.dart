import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  int id; // Unique identifier

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  bool isCompleted;

  Todo({
    required this.id,
    required this.name,
    required this.createdAt,
    this.isCompleted = false,
  });

  Todo copyWith(
      {String? name, DateTime? createdAt, bool? isCompleted, int? id}) {
    return Todo(
      id: this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Todo:\n'
        '  id: $id\n'
        '  name: $name\n'
        '  createdAt: $createdAt';
  }
}
