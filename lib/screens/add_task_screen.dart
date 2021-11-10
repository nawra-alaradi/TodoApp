import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/modals/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String taskTitle = '';
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                taskTitle = newValue;
              },
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 5),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  elevation: 5, backgroundColor: Colors.lightBlueAccent),
              onPressed: () {
                Provider.of<TaskData>(context, listen: false)
                    .addNewTask(taskTitle);
                Navigator.pop(context);
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
