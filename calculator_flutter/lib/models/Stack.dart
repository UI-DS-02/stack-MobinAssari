import 'package:calculator_flutter/models/Node.dart';
class Stack{ //with LinkedList
  int _size = 0;
  Node? _head;
  Node? _tail;
  int size(){
    return _size;
  }
  //get data and add node to the top of the stack
  void push(String data){
    var newNode = Node(data);
    if(_head == null){
      _head = newNode;
      _tail = newNode;
      _size++;
      return;
    }
    newNode.next = _head;
    _head = newNode;
  }
  //remove the
  String pop(){
    var first = _head!.getData();
    _head = _head!.next;
    if(_head == null) _tail = null;
    _size--;
    return first;
  }
  bool isEmpty(){
    return _head == null;
  }

}