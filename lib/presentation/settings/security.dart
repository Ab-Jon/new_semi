import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/settings/support.dart';

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => SecondScreen()));
        }, child: Text('Next Screen')),);
  }
}
