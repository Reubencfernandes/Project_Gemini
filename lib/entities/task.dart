class Task {
  int? id;
  String title;
  String description;
  String category;
  String day;
  DateTime startTime;
  DateTime endTime;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
      'category': category,
      'day': day,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      day: map['day'] as String,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
    );
  }
}
