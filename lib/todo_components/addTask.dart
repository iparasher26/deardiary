import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deardiary/firebase_functions.dart';
import 'package:deardiary/provider/addTask_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({Key? key}) : super(key: key);

  @override
  State<AddTaskBar> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {

  TextEditingController _task = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addTaskProvider=Provider.of<AddTaskProvider>(context,listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: Container(
        height: 75,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.7),
        ),
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.check_box_outline_blank, color: Colors.black, size: 25),
              ),
              Expanded(
                child: TextField(
                  controller: _task,
                  onChanged: (text) {
                    addTaskProvider.updateText(text);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.5),
                    border: InputBorder.none,
                    hintText: 'Add a task',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Consumer<AddTaskProvider>(builder: (context, value, child){
                print("add task build");
                return
                    addTaskProvider.isTextNotEmpty==true ?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 60, // Set the desired width
                        height: 60, // Set the desired height
                        child: InkWell(
                          onTap: () {
                            if (value.isTextNotEmpty==true) {
                              print("Clicked Add");
                              FirebaseFunction().enterTask(_task.text);
                              _task.clear(); //clear text field
                              value.clearText();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black26.withOpacity(0.5),
                            ),
                            child: Icon(Icons.add, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ) :
                    Container();
              }),
            ],
          ),
        ),
      ),
    );
    //   Padding(
    //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
    //   child: Container(
    //     height: 75,
    //     margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20),
    //       color: Colors.grey.withOpacity(0.7),
    //     ),
    //     child: Center(
    //       child: ListTile(
    //         leading: Icon(Icons.check_box_outline_blank, color: Colors.black, size: 25),
    //         title: TextField(
    //           controller: _task,
    //           onChanged: (text){
    //             addTaskProvider.updateText(text);
    //           },
    //           decoration: InputDecoration(
    //             contentPadding: EdgeInsets.symmetric(vertical: 8.5),
    //             border: InputBorder.none,
    //             hintText: 'Add a task',
    //             hintStyle: TextStyle(fontSize: 18, color: Colors.black),
    //           ),
    //         ),
    //         trailing: Container(
    //           height: 60,
    //           width: 60,
    //           child:
    //             Consumer<AddTaskProvider>(builder: (context , value, child){
    //               print("icon");
    //               return (value.isTextNotEmpty==true) ?  Padding(
    //                 padding: const EdgeInsets.all(10.0),
    //                 child: Container(
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10.0),
    //                       color: Colors.black26.withOpacity(0.5),
    //                     ),
    //                     child: IconButton(
    //                       icon: Icon(Icons.add),
    //                       onPressed: () {
    //                         print("Clicked Add");
    //                         FirebaseFunction().enterTask(_task.text);
    //                         _task.clear(); //clear text field
    //                       },
    //                       color: Colors.white,
    //                       iconSize: 20,
    //                     )
    //                 ),
    //               ) : Container();
    //             }),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class AddTask{

  String id;
  final String task;
  final int isActive;
  final int checkbox;

  AddTask({
    required this.id,
    required this.task,
    required this.checkbox,
    required this.isActive,
  });

  Map<String,dynamic> toJson()=>{
    'id':id,
    'task':task,
    'isActive': isActive,
    'checkbox':checkbox
  };

}

