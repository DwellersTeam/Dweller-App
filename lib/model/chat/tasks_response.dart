

class TaskResponse{
  TaskResponse({
    required this.taskId,
    required this.receipientId,
    required this.completed,
    required this.taskDescription,
    required this.taskName,
    required this.taskDueDate,
    required this.taskDueTime,
    required this.createdAt,
  });
  final String taskId;
  final String receipientId;
  bool completed;
  final String taskDescription;
  final String taskName;
  final String taskDueDate;
  final String taskDueTime;
  final String createdAt;


  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      taskId: json["_id"] ?? "",
      receipientId: json['with'] ?? '',
      completed: json['completed'] ?? false,
      taskName: json['name'] ?? '',
      taskDescription: json["description"] ?? "",
      taskDueDate: json['dueDate'] ?? "",
      taskDueTime: json['dueTime'] ?? "",
      createdAt: json['createdAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": taskId,
      'with': receipientId,
      'completed': completed,
      'name': taskName,
      "description": taskDescription,
      'dueDate': taskDueDate,
      'dueTime': taskDueTime,
      'createdAt': createdAt,
    };

  }
}