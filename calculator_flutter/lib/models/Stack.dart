import 'package:calculator_flutter/models/Node.dart';
class Stack{ //with LinkedList
  int _size = 0;
  Node? _head;
  Node? _tail;
  int size(){
    return _size;
  }
  void addLast(String data){
    var newNode = Node(data);
    if(_tail == null){
      _head = newNode;
      _tail = newNode;
      _size++;
      return;
    }
    _tail!.next = newNode;
    _tail = newNode;
  }
  String removeFirst(){
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