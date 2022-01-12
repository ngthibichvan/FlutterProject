import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/bloc/todo/todo_bloc.dart';
import 'package:my_app/bloc/todo/todo_event.dart';
import 'package:my_app/bloc/todo/todo_state.dart';
import 'package:my_app/pages/to_do_list/task_model.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  late TextEditingController _taskIdController = TextEditingController();
  late TextEditingController _taskTextController = TextEditingController();
  late TextEditingController _noteController = TextEditingController();

  final List<TaskModel> taskLists = [
    TaskModel('1', 'note 1', 'Task 1'),
    TaskModel('2', 'note 2', 'Task 2'),
    TaskModel('3', 'note 3', 'Task 3'),
    TaskModel('4', 'note 4', 'Task 4'),
    TaskModel('5', 'note 5', 'Task 5'),
    TaskModel('6', 'note 6', 'Task 6'),
  ];
  late String _mode = 'taskView';

  Widget cardWidget(TaskModel task, BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          ListTile(
            leading: Text('${task.taskId}'),
            title: Text(task.task),
            subtitle: Text(
              task.note,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: Wrap(
              children: [
                IconButton(
                    onPressed: () =>
                        context.read<TodoBloc>().add(EditTaskEvent(task)),
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFFEF5350),
                    )),
                IconButton(
                    onPressed: () =>
                        context.read<TodoBloc>().add(DeleteTaskEvent(task)),
                    icon: const Icon(
                      Icons.delete,
                      color: Color(0xFFEF5350),
                    ))
              ],
            ),
          ),
        ]));
  }

  Widget listCard(taskLists, context) {
    return Column(children: [
      TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        ),
        onPressed: () {
          setState(() {
            _mode = 'add';
          });
        },
        child: const Text('Add task'),
      ),
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: taskLists.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: cardWidget(taskLists[index], context),
            );
          }),
    ]);
  }

  Widget addTask(taskLists, BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _taskIdController,
              decoration: const InputDecoration(
                labelText: 'TaskID',
              ),
            ),
            TextField(
              controller: _taskTextController,
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note',
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
              onPressed: () {
                context.read<TodoBloc>().add(AddTaskEvent(TaskModel(
                    _taskIdController.text,
                    _taskTextController.text,
                    _noteController.text)));
                setState(() {
                  _mode = 'taskView';
                });
              },
              child: const Text('Add task'),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(taskLists),
      child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) => _mode == 'edit'
              ? Container(child: listCard(state.taskLists, context))
              : (_mode == 'add'
                  ? Container(child: addTask(state.taskLists, context))
                  : Container(child: listCard(state.taskLists, context)))),
    );
  }
}
