import 'package:flutter/material.dart';

class ProgressAdded extends StatelessWidget {
  const ProgressAdded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 236, 231),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Successfully Added...'),
            SizedBox(height: 35,),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Add Another One')
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Go back to Home Page')
            ),
          ],
        ),
      ),
    );
  }
}