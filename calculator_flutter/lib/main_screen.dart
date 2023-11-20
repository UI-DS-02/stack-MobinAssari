import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> historyNumberList = [];
  var textEditingController = TextEditingController(text: "Enter:");


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
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText("(");}, child: Text("(",style: TextStyle(fontSize: 24),),),),
        Container(width: buttonSize,height: buttonSize,decoration: BoxDecoration(color: Color(0xff030d0e)),child: TextButton(onPressed: (){changeText(")");}, child: Text(")",style: TextStyle(fontSize: 24),),),),
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

}
