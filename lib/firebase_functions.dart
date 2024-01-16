import 'package:deardiary/todo_components/addTask.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseFunction{

  FirebaseFirestore firestore= FirebaseFirestore.instance;
  FirebaseAuth auth=FirebaseAuth.instance;

  String getUserId()                     // non-static function
  {
    return auth.currentUser?.uid ??'';  // uid can be null, return type is not ; so (if uid is null, return empty string)
  }

  Future<void> logOut() async{
    await auth.signOut();
  }

  Future<bool> enterTask(String task) async{

    final taskId=FirebaseFirestore.instance.collection('ToDoList');

    AddTask object = AddTask(
        task: task.toString(),
        isActive: 1,
        checkbox: 0,
        id: FirebaseFunction().getUserId()  // non-static function's object created using ()
    );

    final json = object.toJson();

    try{
      DocumentReference a = await taskId.add(json);  // click+ctrl = original function definition
      debugPrint(a.id);
    } catch(e,s){
      debugPrint(s.toString());
      debugPrint(e.toString());           // s prints which line has error
    }

    return true;
  }

// deleteTask
// 1. isActive = 0 on a given id document

 Future<void> deleteTask(String documentId) async{

   var snapshot = await firestore.collection('ToDoList').doc(documentId);
   snapshot
       .update({'isActive' : 0}) // <-- Updated data
       .then((_) => print('Updated'))
       .catchError((error) => print('Update failed: $error'));

 }

// strike through
// checkbox 1 on a given id document
Future<void> strikethrough(String documentId, int checkbox) async{

  var snapshot = await firestore.collection('ToDoList').doc(documentId);
  if(checkbox==0)
    {
      snapshot
          .update({'checkbox' : 1})// <-- Updated data
          .then((_) => print('Updated'))
          .catchError((error) => print('Update failed: $error'));
    }
  else
    {
      snapshot
          .update({'checkbox' : 0})// <-- Updated data
          .then((_) => print('Updated'))
          .catchError((error) => print('Update failed: $error'));
    }
}
}