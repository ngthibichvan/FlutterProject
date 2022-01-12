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
  late final TextEditingController _taskIdController = TextEditingController();
  late final TextEditingController _taskTextController =
      TextEditingController();
  late final TextEditingController _noteController = TextEditingController();

  final List<TaskModel> taskLists = [
    TaskModel('1', 'note 1', 'Task 1'),
    TaskModel('2', 'note 2', 'Task 2'),
    TaskModel('3', 'note 3', 'Task 3'),
    TaskModel('4', 'note 4', 'Task 4')
  ];
  late String _mode = 'taskView';
  late TaskModel _task;

  Widget cardWidget(TaskModel task, BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          ListTile(
            leading: Text(task.taskId),
            title: Text(task.task),
            subtitle: Text(
              task.note,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: Wrap(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _mode = 'edit';
                        _task = task;
                      });
                    },
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
            TextFormField(
              controller: _taskIdController,
              decoration: const InputDecoration(
                labelText: 'TaskID',
              ),
            ),
            TextFormField(
              controller: _taskTextController,
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
            ),
            TextFormField(
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

  Widget editTask(taskLists, BuildContext context, TaskModel task) {
    String _newTask = task.task;
    String _newNote = task.note;
    String _newId = task.taskId;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Container(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: task.taskId,
                  decoration: const InputDecoration(
                    labelText: 'TaskID',
                  ),
                  onSaved: (newValue) => _newId = newValue ?? '',
                ),
                TextFormField(
                    initialValue: task.task,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                    ),
                    onSaved: (newValue) => _newTask = newValue ?? ''),
                TextFormField(
                    initialValue: task.note,
                    decoration: const InputDecoration(
                      labelText: 'Note',
                    ),
                    onSaved: (newValue) => _newNote = newValue ?? ''),
                TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    _formKey.currentState?.save();
                    context.read<TodoBloc>().add(
                        EditTaskEvent(TaskModel(_newId, _newNote, _newTask)));
                    setState(() {
                      _mode = 'taskView';
                    });
                  },
                  child: const Text('Add task'),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(taskLists),
      child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) => _mode == 'edit'
              ? Container(child: editTask(state.taskLists, context, _task))
              : (_mode == 'add'
                  ? Container(child: addTask(state.taskLists, context))
                  : Container(child: listCard(state.taskLists, context)))),
    );
  }
}
