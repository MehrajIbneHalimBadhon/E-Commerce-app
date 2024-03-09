import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyles{
  //loading
  progressDialog(context)
  {
    showDialog(context: context, builder: (context){
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/files/loading.gif',height: 150,),
      );
    });
  }

  //failed snacber
GetSnackBar failedSnacBar(message)=>GetSnackBar(
  message: message,
  backgroundColor: Colors.red,
  duration: const Duration(seconds: 2),
  icon: const Icon(Icons.warning),
);

//success snacber
  GetSnackBar successSnacBar(message)=>GetSnackBar(
    message: message,
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 2),
    icon: const Icon(Icons.assignment_turned_in_outlined),
  );
}