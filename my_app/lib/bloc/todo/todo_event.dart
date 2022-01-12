import 'package:equatable/equatable.dart';
import 'package:my_app/pages/to_do_list/task_model.dart';

abstract class TodoEvent extends Equatable {
  final TaskModel task;

  const TodoEvent(
    this.task,
  );

  @override
  List<Object?> get props => [];
}

class EditTaskEvent extends TodoEvent {
  const EditTaskEvent(TaskModel task) : super(task);
}

class DeleteTaskEvent extends TodoEvent {
  const DeleteTaskEvent(TaskModel task) : super(task);
}

class AddTaskEvent extends TodoEvent {
  const AddTaskEvent(TaskModel task) : super(task);
}
