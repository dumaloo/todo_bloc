class Todo {
  final String name;
  final DateTime createdAt;
  Todo({
    required this.name,
    required this.createdAt,
  });

  Todo copyWith({String? name, DateTime? createdAt}) {
    return Todo(
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Todo{name: $name, createdAt: $createdAt}';
  }
}
