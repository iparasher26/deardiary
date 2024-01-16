import 'dart:ffi';

import 'package:deardiary/firebase_functions.dart';
import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  final String task;
  final int checkBox;
  final String id;
  const ToDoItem({Key? key, required this.id, required this.task, required this.checkBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey.withOpacity(0.3),
      ),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListTile(
        onTap: () async{
          await FirebaseFunction().strikethrough(id,checkBox);
          },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        leading: Icon(checkBox==0 ? Icons.check_box_outline_blank : Icons.check_box, color: Colors.black,),
        title: Text(task,style: TextStyle(fontSize: 16, decoration: checkBox==1 ? TextDecoration.lineThrough : null),),
        trailing: Container(
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              await FirebaseFunction().deleteTask(id);
              },
            color: Colors.white,
            iconSize: 20,
          ),
        ),
      ),
    );
  }
}
