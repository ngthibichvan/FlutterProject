import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/todo/todo_event.dart';
import 'package:my_app/bloc/todo/todo_state.dart';
import 'package:my_app/pages/to_do_list/task_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(taskLists) : super(TodoState(taskLists: taskLists)) {
    on<EditTaskEvent>(_onEdit);
    on<DeleteTaskEvent>(_onDelete);
    on<AddTaskEvent>(_onAdd);
  }

  void _onEdit(EditTaskEvent event, Emitter<TodoState> emit) {
    final finalTasks = state.taskLists
        .map((x) => x.taskId == event.task.taskId ? event.task : x)
        .toList();
    emit(TodoState(taskLists: finalTasks));
  }

  void _onDelete(DeleteTaskEvent event, Emitter<TodoState> emit) {
    final finalTasks =
        state.taskLists.where((x) => x.taskId != event.task.taskId).toList();
    emit(TodoState(taskLists: finalTasks));
  }

  void _onAdd(AddTaskEvent event, Emitter<TodoState> emit) {
    final List<TaskModel> finalTasks = List.from(state.taskLists)
      ..add(event.task);
    emit(TodoState(taskLists: finalTasks));
  }
}
