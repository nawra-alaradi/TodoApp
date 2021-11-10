import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:todoey_flutter/widgets/task_tile.dart';
import 'package:todoey_flutter/widgets/tasks_list.dart';
import 'package:todoey_flutter/screens/add_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/modals/task_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey_flutter/screens/login_screen.dart';
import 'package:todoey_flutter/services.dart';

class TasksScreen extends StatelessWidget {
  // String newTaskTitle = '';
  static const String id = "TasksScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(
                    // typingNewTask: (newValue) {
                    //   newTaskTitle = newValue;
                    // },
                    // addingNewTask: () {
                    //   // setState(() {
                    //   //   Provider.of<TaskData>(context)
                    //   //       .tasks
                    //   //       .add(Task(name: newTaskTitle));
                    //   // });
                    //   Navigator.pop(context);
                    // },
                    ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Provider.of<TaskData>(context, listen: false).deleteAll();
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () async {
                      bool res = await Provider.of<Auth>(context, listen: false)
                          .signOut();
                      if (res) {
                        Navigator.pushNamed(context, LoginScreen.id);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.signOutAlt,
                      size: 30,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Todoey',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                '${Provider.of<TaskData>(context, listen: true).taskCount} Tasks',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            height: 50,
            child: TasksList(),
          ),
        )
      ]),
    );
  }
}
