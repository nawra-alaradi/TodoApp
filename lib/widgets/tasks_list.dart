import 'package:flutter/material.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/modals/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.taskCount,
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              longPressCallback: () {
                taskData.deleteTask(task);
              },
              isChecked: task.isDone,
              taskTitle: task.name,
              toggleCheckbox: (checkboxState) {
                taskData.updateTask(task);
                // setState(
                //   () {
                //     Provider.of<TaskData>(context)
                //         .tasks[index]
                //         .toggleDone();
                //   },
                // );
              },
            );
          },
        );
      },
    );
  }
}
