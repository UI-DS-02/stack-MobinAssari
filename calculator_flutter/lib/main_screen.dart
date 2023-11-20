import 'dart:ffi';
import 'dart:math';

import 'package:calculator_flutter/models/MyStack.dart';
import 'package:calculator_flutter/models/Operator.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> historyNumberList = [];
  var textEditingController = TextEditingController(text: "Enter:");
  var operatorList = [
    Operator("!", 1),
    Operator("^", 2),
    Operator("*", 3),
    Operator("/", 3),
    Operator("+", 4),
    Operator("-", 4),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff000807),),
        child:  Column(


          children: [
            historyNumbers(),
            currentText(),
            Expanded(child: keyboard())
          ],
        ),
      ),
    );
  }

  Widget historyNumbers() {
    return Container(
      //color: Colors.white,
      height: MediaQuery.of(context).size.height *0.30,
      child: ListView.builder(itemBuilder: (context, index) {
        return const ListTile();
      }),
    );
  }

  Widget currentText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: textEditingController,style: TextStyle(color: Colors.white,fontSize: 24),),
          ],
        ),
      ),
    );
  }


  Widget keyboard() {
    var buttonSize = MediaQuery.of(context).size.width * 0.242;
    void changeText(String text){
      textEditingController.text += text;
    }

    List<Widget> buttonRows = [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff030d0e)),child: ElevatedButton(onPressed: (){changeText("(");}, child: Text("(",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff030d0e)),child: ElevatedButton(onPressed: (){changeText(")");}, child: Text(")",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText("!");}, child: Text("!",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff0b4044)),child: TextButton(onPressed: (){changeText("+");}, child: Text("+",style: TextStyle(fontSize: 24),),),),
      ],),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("7",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("8",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("9",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff0b4044)),child: TextButton(onPressed: (){}, child: Text("-",style: TextStyle(fontSize: 24),),),),
      ],),Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("4",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("5",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("6",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff0b4044)),child: TextButton(onPressed: (){}, child: Text("*",style: TextStyle(fontSize: 24),),),),
      ],),Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("1",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("2",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("3",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff0b4044)),child: TextButton(onPressed: (){}, child: Text("/",style: TextStyle(fontSize: 24),),),),
      ],),Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text(".",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("0",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){}, child: Text("^",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff0b4044)),child: TextButton(onPressed: (){}, child: Text("=",style: TextStyle(fontSize: 24),),),),
      ],),



    ];


    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...buttonRows,
          ],
        ),
      ),
    );
  }
  String convertInfixToPostfix(String infix){
    String postfix = "";
    var operatorStack = MyStack();
    var operandStack = MyStack();
    String currentNum = "";
    for(var i = 0; i< infix.length; i++){
      bool isOperand = ".0123456789".contains(infix[i]);
      if(isOperand){
        currentNum += "${infix[i]} ";
      }
      else {
        if (currentNum.isNotEmpty) {
          postfix += currentNum;
          currentNum = "";
        }

        switch (infix[i]) {
          case "=":
            break;

          case "(":
          case "-":
          case "+":
            operatorStack.push(infix[i]);
            break;

          case ")":


          case "e":
            postfix += exp(1).toString();
            break;

          case"p":
            postfix += pi.toString();
            break;

          default:{
            if(findPrecedence(infix[i])<findPrecedence(operatorStack.first())){
              postfix += "${operatorStack.pop()} ";
            }
            operandStack.push(infix[i]);
            break;
        }}
      }
    }

    return postfix;
  }
  int findPrecedence(String char){
    for (var operator in operatorList){
      if(operator.char == char){
        return operator.precedence;
      }
    }
    return 0;
  }

}
