import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modals/progress_modal.dart';

class AddProgress extends StatefulWidget {
  AddProgress({Key? key}) : super(key: key);

  @override
  State<AddProgress> createState() => _AddProgressState();
}

class _AddProgressState extends State<AddProgress> {
  TextEditingController dateController = TextEditingController();
  TextEditingController progressController = TextEditingController();

  final auth = FirebaseAuth.instance;

  userUID(){
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 217, 212),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Date',
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                TextField(
                  controller: progressController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Write your progress here...',
                  ),
                  maxLines: 25,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          final date = dateController.text;
          final progress = progressController.text;
          if(date == "" || progress ==""){
            final snackBar = SnackBar(content: const Text('Date or Progress cannot be empty'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else{
            createEntry(date: date, progress: progress);
            Navigator.pushNamed(context, '/progress_added');
            dateController.text = '';
            progressController.text = '';
          }
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Text('Done'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future createEntry({required String date, required String progress}) async {
    String collectionName = userUID();
    final progressInstance =
        FirebaseFirestore.instance.collection(collectionName).doc();

    final progressClass = Progress(
      id: progressInstance.id,
      date: date,
      progress: progress
    );

    final json = progressClass.toJson();

    await progressInstance.set(json);
  }
}
