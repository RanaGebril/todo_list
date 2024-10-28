import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime data) {
    var collection = getTaskCollection();
    return collection
        .where("date",
        isEqualTo: DateUtils
            .dateOnly(data)
            .millisecondsSinceEpoch)
        .snapshots();
  }

  static void deleteTask(String id) {
    var collection = getTaskCollection();
    collection.doc(id).delete();
  }

  static void editTask(TaskModel task) {
    getTaskCollection().doc(task.id).update(task.toJson());
  }
}