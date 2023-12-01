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
  double? buttonWidth;

  @override
  void initState() {
    //buttonWidth = MediaQuery.of(context).size.width * 0.24 ;
    super.initState();
  }

  List<String> history = [];

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
        decoration: const BoxDecoration(
          color: Color(0xff000807),
        ),
        child: Column(
          children: [
            historyNumbers(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: currentText(),
            ),
            Expanded(child: keyboard())
          ],
        ),
      ),
    );
  }

  Widget historyNumbers() {
    return SizedBox(
      //color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.32,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  var findIndex =
                      history[history.length - index - 1].indexOf("=");
                  setState(() {
                    textEditingController.text =
                        history[history.length - index - 1]
                            .substring(0, findIndex);
                  });
                },
                child: Text(
                  history[history.length - index - 1],
                  style: const TextStyle(color: Colors.white30, fontSize: 18),
                ),
              );
            }),
      ),
    );
  }

  Widget currentText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            width: double.maxFinite,
            child: TextField(
                controller: textEditingController,
                style: const TextStyle(color: Colors.white, fontSize: 24),
                readOnly: true),
          ),
        ),
      ],
    );
  }

  Widget keyboard() {
    //var buttonWidth = MediaQuery.of(context).size.width * 0.24 ;

    var mainAxisAlignment = MainAxisAlignment.start;
    var buttonHeight = MediaQuery.of(context).size.width * 0.24;
    void buttonWidthAnimator() {
      if (!minimize) {
        setState(() {
          mainAxisAlignment = MainAxisAlignment.start;

          buttonWidth = MediaQuery.of(context).size.width * 0.24;
        });
      } else {
        setState(() {
          mainAxisAlignment = MainAxisAlignment.spaceEvenly;

          buttonWidth = MediaQuery.of(context).size.width * 0.24 * 4 / 5;
        });
      }
      minimize = !minimize;
    }

    void changeText(String text) {
      if (textEditingController.text.length < 25) {
        textEditingController.text += text;
      }
    }

    Color numColors = const Color(0xff082931);
    Duration sizeChangeDuration = const Duration(milliseconds: 300);

    List<Widget> buttonRows = [
      Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 10, 51, 59),
                        Color.fromARGB(255, 13, 70, 75)
                      ]),
                ),
                child: TextButton(
                  onPressed: () {
                    changeText("+");
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(color: Color(0xff030d0e)),
                child: TextButton(
                  onPressed: () {
                    changeText("(");
                  },
                  child: const Text(
                    ")",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(color: Color(0xff030d0e)),
                child: TextButton(
                  onPressed: () {
                    changeText(")");
                  },
                  child: const Text(
                    "(",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Expanded(
                child: AnimatedContainer(
              duration: sizeChangeDuration,
              width: buttonWidth,
              height: buttonHeight,
              decoration: const BoxDecoration(color: Color(0xff030d0e)),
              child: minimize
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        changeText("!");
                      },
                      child: const Text(
                        "!",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(color: Color(0xff030d0e)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      buttonWidthAnimator();
                      //minimize = !minimize;
                    });
                  },
                  child: Text(
                    minimize ? "->" : "<-",
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 10, 51, 59),
                        Color.fromARGB(255, 13, 70, 75)
                      ]),
                ),
                child: TextButton(
                  onPressed: () {
                    changeText("-");
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("7");
                  },
                  child: const Text(
                    "7",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("8");
                  },
                  child: const Text(
                    "8",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("9");
                  },
                  child: const Text(
                    "9",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Expanded(
                child: AnimatedContainer(
              duration: sizeChangeDuration,
              width: buttonWidth,
              height: buttonHeight,
              decoration: const BoxDecoration(color: Color(0xff030d0e)),
              child: minimize
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        changeText("^");
                      },
                      child: const Text(
                        "^",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
            )),
          ],
        ),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 10, 51, 59),
                        Color.fromARGB(255, 13, 70, 75)
                      ]),
                ),
                child: TextButton(
                  onPressed: () {
                    changeText("*");
                  },
                  child: const Text(
                    "*",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("4");
                  },
                  child: const Text(
                    "4",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("5");
                  },
                  child: const Text(
                    "5",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("6");
                  },
                  child: const Text(
                    "6",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Expanded(
                child: AnimatedContainer(
              duration: sizeChangeDuration,
              width: buttonWidth,
              height: buttonHeight,
              decoration: const BoxDecoration(color: Color(0xff030d0e)),
              child: minimize
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        changeText("e");
                      },
                      child: const Text(
                        "e",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
            )),
          ],
        ),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 10, 51, 59),
                        Color.fromARGB(255, 13, 70, 75)
                      ]),
                ),
                child: TextButton(
                  onPressed: () {
                    changeText("/");
                  },
                  child: const Text(
                    "/",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("1");
                  },
                  child: const Text(
                    "1",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("2");
                  },
                  child: const Text(
                    "2",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("3");
                  },
                  child: const Text(
                    "3",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Expanded(
                child: AnimatedContainer(
              duration: sizeChangeDuration,
              width: buttonWidth,
              height: buttonHeight,
              decoration: const BoxDecoration(color: Color(0xff030d0e)),
              child: minimize
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        changeText("p");
                      },
                      child: const Text(
                        "p",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
            )),
          ],
        ),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 28, 117, 109),
                        Color.fromARGB(255, 43, 180, 167)
                      ]),
                ),
                child: TextButton(
                  onPressed: () {
                    convertInfixToPostfix(textEditingController.text);
                  },
                  child: const Text(
                    "=",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: AnimatedContainer(
                    duration: sizeChangeDuration,
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: const BoxDecoration(color: Color(0xff050f11)),
                    child: IconButton(
                      onPressed: textEditingController.text != ""
                          ? () {
                              textEditingController.text =
                                  textEditingController.text.substring(
                                      0, textEditingController.text.length - 1);
                            }
                          : () {},
                      icon: const Icon(
                        Icons.backspace_outlined,
                      ),
                      color: Colors.white,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(color: numColors),
                child: TextButton(
                  onPressed: () {
                    changeText("0");
                  },
                  child: const Text(
                    "0",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: AnimatedContainer(
                duration: sizeChangeDuration,
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(color: Color(0xff050f11)),
                child: TextButton(
                  onPressed: () {
                    changeText(".");
                  },
                  child: const Text(
                    ".",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Expanded(
                child: AnimatedContainer(
              duration: sizeChangeDuration,
              width: buttonWidth,
              height: buttonHeight,
              decoration: const BoxDecoration(color: Color(0xff030d0e)),
              child: minimize
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        textEditingController.text = "";
                      },
                      child: const Text(
                        "c",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
            )),
          ],
        ),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...buttonRows,
        ],
      ),
    );
  }

  void convertInfixToPostfix(String infix) {
    if(infix.contains("error")) return;
    String postfix = "";
    var operatorStack = MyStack();
    //var operandStack = MyStack();
    String currentNum = "";
    for (var i = 0; i < infix.length; i++) {
      bool isOperand = ".0123456789 ".contains(infix[i]);
      if (isOperand) {
        currentNum += infix[i];
      } else {
        if (currentNum.isNotEmpty) {
          postfix += "$currentNum ";
          currentNum = "";
        }

        switch (infix[i]) {
          case "(":
            operatorStack.push("(");
            break;

          case ")":
            while (!operatorStack.isEmpty() && operatorStack.first() != "(") {
              postfix += "${operatorStack.pop()} ";
            }
            operatorStack.pop();
            break;

          case "e":
            currentNum = exp(1).toString();
            break;

          case "p":
            currentNum = pi.toString();
            break;

          case "+":
          case "-":
          case "*":
          case "/":
          case "^":
          case "!":
            if (!operatorStack.isEmpty() &&
                findPrecedence(infix[i]) >=
                    findPrecedence(operatorStack.first()!) &&
                operatorStack.first() != "(") {
              while (!operatorStack.isEmpty() &&
                  findPrecedence(infix[i]) >=
                      findPrecedence(operatorStack.first()!) &&
                  operatorStack.first() != "(") {
                postfix += "${operatorStack.pop()} ";
              }
            }
            operatorStack.push(infix[i]);
            break;

          default:
            break;
        }
      }
    }
    if (currentNum.isNotEmpty) postfix += "$currentNum ";
    String? temp = operatorStack.pop();
    while (temp != null) {
      postfix += "$temp ";
      temp = operatorStack.pop();
    }
    var tempResult = calculatePostFix(postfix);
    if (tempResult == "error") {
      setState(() {
        textEditingController.text = "error";
      });
      return;
    }

    var calculateResult = double.parse(tempResult);
    num result;
    if (calculateResult % 10 == 0) {
      result = calculateResult.round();
    } else {
      result = calculateResult;
    }
    setState(() {
      textEditingController.text = result.toString();
      history.add("$infix = $result");
    });
  }

  int findPrecedence(String char) {
    for (var operator in operatorList) {
      if (operator.char == char) {
        return operator.precedence;
      }
    }
    return -1;
  }

  String calculatePostFix(String postfix) {
    try {
      var currentNum = "";
      var operandStack = MyStack();
      for (var i = 0; i < postfix.length; i++) {
        if (postfix[i] == " ") {
          if (currentNum.isNotEmpty) operandStack.push(currentNum);
          currentNum = "";
          continue;
        }
        bool isOperand = ".0123456789 ".contains(postfix[i]);

        if (isOperand) {
          currentNum += postfix[i];
        } else {
          if (currentNum.isNotEmpty) {
            operandStack.push(currentNum);
            currentNum = "";
          }
          var num1 = double.parse(operandStack.pop()!);
          num? num2;
          if (/*operandStack.first() != null &&*/ postfix[i] == "!") {
            num2 = 1;
          } else {
            num2 = double.parse(operandStack.pop()!);
          }

          switch (postfix[i]) {
            case "+":
              operandStack.push((num1 + num2).toString());
            case "-":
              operandStack.push((num2 - num1).toString());
            case "*":
              operandStack.push((num1 * num2).toString());
            case "/":
              operandStack.push((num2 / num1).toString());
            case "^":
              operandStack.push((pow(num2, num1)).toString());
            case "!":
              operandStack.push(factorial(num1).toString());
              break;
            default:
              break;
          }
        }
      }
      return operandStack.first()!;
    } catch (e) {
      return "error";
    }
  }

  double factorial(double k) {
    if (k < 0) {
      throw ArgumentError.value(k);
    }
    if (k == 0) {
      return 1;
    }
    var result = k;
    k--;
    while (k > 1) {
      result *= k;
      k--;
    }
    return result;
  }
}
