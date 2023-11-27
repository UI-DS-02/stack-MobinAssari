import 'dart:math';

import 'package:calculator_flutter/models/MyStack.dart';
import 'package:calculator_flutter/models/Operator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double? buttonWidth;

  @override
  void initState() {
    //buttonWidth = MediaQuery.of(context).size.width * 0.24 ;
    super.initState();
  }
  List<String> historyNumberList = [];

  bool minimize = true;
  var textEditingController = TextEditingController();
  var operatorList = [
    Operator("!", 1),
    Operator("^", 2),
    Operator("*", 3),
    Operator("/", 3),
    Operator("+", 4),
    Operator("-", 4),
  ];


  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

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
      height: MediaQuery.of(context).size.height *0.32,
      child: ListView.builder(itemBuilder: (context, index) {
        return const ListTile();
      }),
    );
  }

  Widget currentText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Expanded(
          child: Container(
            width: double.maxFinite ,
              child: TextField(controller: textEditingController, style: TextStyle(color: Colors.white,fontSize: 24),readOnly: true),
          ),
        ),
      ],
    );
  }


  Widget keyboard() {
    //var buttonWidth = MediaQuery.of(context).size.width * 0.24 ;

    var mainAxisAlignment = MainAxisAlignment.start;
    var buttonHeight = MediaQuery.of(context).size.width * 0.24;
    void buttonWidthAnimator(){
      if(!minimize){
        setState(() {
          mainAxisAlignment = MainAxisAlignment.start ;

          buttonWidth = MediaQuery.of(context).size.width * 0.24;

        });
      }
      else{
        setState(() {
          mainAxisAlignment = MainAxisAlignment.spaceEvenly;

          buttonWidth = MediaQuery.of(context).size.width * 0.24 * 4/5;
        });
      }
      minimize = !minimize;
    }


    void changeText(String text){
      if(textEditingController.text.length < 25) textEditingController.text += text;
    }
    Color numColors = Color(0xff082931);
    Duration sizeChangeDuration = const Duration(milliseconds: 300);

    List<Widget> buttonRows = [
      Directionality(
        textDirection: TextDirection.rtl,
        child: Row(mainAxisAlignment: mainAxisAlignment ,crossAxisAlignment: CrossAxisAlignment.center, children: [
          AnimatedContainer(duration: sizeChangeDuration, width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromARGB(
              255, 10, 51, 59),Color.fromARGB(255, 13, 70, 75)]),),child: TextButton(onPressed: (){changeText("+");}, child: Text("+",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration, width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText("(");}, child: Text(")",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration, width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText(")");}, child: Text("(",style: TextStyle(fontSize: 24),),),),
          if(!minimize) Expanded(child: AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText("!");}, child: Text("!",style: TextStyle(fontSize: 24),),),)),
          AnimatedContainer(duration: sizeChangeDuration, width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){ setState(() {
            buttonWidthAnimator();
            //minimize = !minimize;
          });}, child: Text( minimize ? "->" : "<-" ,style: TextStyle(fontSize: 24),),),),


        ],),
      ),
      Directionality(textDirection: TextDirection.rtl,
        child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromARGB(
              255, 10, 51, 59),Color.fromARGB(255, 13, 70, 75)]),),child: TextButton(onPressed: (){changeText("-");}, child: Text("-",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("7");}, child: Text("7",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("8");}, child: Text("8",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("9");}, child: Text("9",style: TextStyle(fontSize: 24),),),),
          if(!minimize) Expanded(child: AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText("^");}, child: Text("^",style: TextStyle(fontSize: 24),),),)),

        ],),
      ),
      Directionality(textDirection: TextDirection.rtl,
        child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromARGB(
              255, 10, 51, 59),Color.fromARGB(255, 13, 70, 75)]),),child: TextButton(onPressed: (){changeText("*");}, child: Text("*",style: TextStyle(fontSize: 24),),),),

          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("4");}, child: Text("4",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("5");}, child: Text("5",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("6");}, child: Text("6",style: TextStyle(fontSize: 24),),),),
          if(!minimize) Expanded(child: AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText("e");}, child: Text("e",style: TextStyle(fontSize: 24),),),)),

        ],),
      ),
      Directionality(textDirection: TextDirection.rtl,
        child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromARGB(
              255, 10, 51, 59),Color.fromARGB(255, 13, 70, 75)]),),child: TextButton(onPressed: (){changeText("/");}, child: Text("/",style: TextStyle(fontSize: 24),),),),

          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("1");}, child: Text("1",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("2");}, child: Text("2",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("3");}, child: Text("3",style: TextStyle(fontSize: 24),),),),
          if(!minimize) Expanded(child: AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText("p");}, child: Text("p",style: TextStyle(fontSize: 24),),),)),

        ],),
      ),
      Directionality(textDirection: TextDirection.rtl,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromARGB(
              255, 28, 117, 109),Color.fromARGB(255, 43, 180, 167)]),),child: TextButton(onPressed: (){print(convertInfixToPostfix(textEditingController.text));}, child: Text("=",style: TextStyle(fontSize: 24),),),),

          Directionality(textDirection: TextDirection.ltr, child: AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff050f11)),child: IconButton(onPressed: textEditingController.text != "" ? (){print(textEditingController.text); textEditingController.text = textEditingController.text.substring(0,textEditingController.text.length-1);} : (){}, icon: Icon(Icons.backspace_outlined,),color: Colors.white,),)),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: numColors),child: TextButton(onPressed: (){changeText("0");}, child: Text("0",style: TextStyle(fontSize: 24),),),),
          AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff050f11)),child: TextButton(onPressed: (){changeText(".");}, child: Text(".",style: TextStyle(fontSize: 24),),),),
          if(!minimize) Expanded(child: AnimatedContainer(duration: sizeChangeDuration,width: buttonWidth,height: buttonHeight,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){textEditingController.text = "";}, child: Text("c",style: TextStyle(fontSize: 24),),),)),

        ],),
      ),
    ];


    return Container(
      padding: const EdgeInsets.all(0.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...buttonRows,
          ],
        ),

    );
  }
  String convertInfixToPostfix(String infix){
    String postfix = "";
    var operatorStack = MyStack();
    //var operandStack = MyStack();
    String currentNum = "";
    for(var i = 0; i< infix.length; i++){
      bool isOperand = ".0123456789 ".contains(infix[i]);
      if(isOperand){
        currentNum += infix[i];
      }
      else {
        if (currentNum.isNotEmpty) {
          postfix += "$currentNum ";
          currentNum = "";
        }

        switch (infix[i]) {
          case "(":
            operatorStack.push(infix[i]);
            break;

          case ")":
            var first = operatorStack.pop();
            while(first != "("){
              postfix += "$first ";
              first = operatorStack.pop();
            }
            break;

          case "e":
            postfix += exp(1).toString();
            break;

          case"p":
            postfix += pi.toString();
            break;

          case"+":
          case"-":
          case"*":
          case"/":
          case"^":
          case"!":
            if(operatorStack.first() == null){
              operatorStack.push(infix[i]);
            }
            else if(findPrecedence(infix[i])>findPrecedence(operatorStack.first()!)){
              postfix += "${operatorStack.pop()} ";
              operatorStack.push(infix[i]);
            }
            else{
              operatorStack.push(infix[i]);
            }
            break;
          default:
            break;
        }
      }
    }
    if(currentNum.isNotEmpty) postfix += "${currentNum} ";
    String? temp = operatorStack.pop();
    while(temp != null){
      postfix += "${temp} ";
      temp = operatorStack.pop();
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
