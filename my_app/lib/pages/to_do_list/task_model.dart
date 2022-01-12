class TaskModel {
  //final bool complete;
  final String taskId;
  final String note;
  final String task;

  TaskModel(this.taskId, this.note, this.task);

  TaskModel copyWith({
    //bool? complete,
    String? taskId,
    String? note,
    String? task,
  }) {
    return TaskModel(
      taskId ?? this.taskId,
      note ?? this.note,
      task ?? this.task,
    );
  }
}
