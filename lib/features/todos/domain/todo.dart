class Todo {
  final String id;
  final String title;

  Todo(this.id, this.title);

  Todo.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'];

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}
