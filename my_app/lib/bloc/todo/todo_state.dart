import 'package:equatable/equatable.dart';
import 'package:my_app/pages/to_do_list/task_model.dart';

class TodoState extends Equatable {
  final List<TaskModel> taskLists;
  const TodoState({
    required this.taskLists,
  });

  @override
  List<Object?> get props => taskLists;
}
