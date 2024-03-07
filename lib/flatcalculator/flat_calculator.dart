import 'package:flutter/material.dart';

class FlatCalculatorPage extends StatefulWidget {
  const FlatCalculatorPage({super.key});

  @override
  State<FlatCalculatorPage> createState() => _FlatCalculatorPageState();
}

class _FlatCalculatorPageState extends State<FlatCalculatorPage> {
  static var userQuestion = '';
  double answer = 0; //used to compute
  var displayAnswer = ''; //display final answer
  var colourTheme = Colors.deepPurple;
  static List<String> finalElements = List.empty();
  static var editQuestion = '';

  void _buttonEqual() {
    answer = 0;

    editQuestion = userQuestion;

    for (var i = 0; i < editQuestion.length - 2; i++) {
      //check for Double Negation
      if (editQuestion[i] == '-' && editQuestion[i + 1] == '-') {
        // 1--2 -> 1+2
        editQuestion = editQuestion.substring(0, i) +
            '+' +
            editQuestion.substring(i + 2, editQuestion.length);
      }
    }

    for (var i = 1; i < editQuestion.length; i++) {
      //check for double plus
      if (editQuestion[i] == '+' && editQuestion[i - 1] == '+') {
        // 1+++2 -> 1+0+0+0+2
        editQuestion = editQuestion.substring(0, i) +
            '0' +
            editQuestion.substring(i, editQuestion.length);
      }
    }

    // +9 becomes 0+9
    if (editQuestion[0] == '+') {
      editQuestion = '0' + editQuestion;
    }

    //if the question starts with a number, add +0, this just helps with the addition functions
    if (startsWithNumber(editQuestion)) {
      editQuestion = '0+' + editQuestion;
    }

    //check if there's a '-' sign, execute subtraction
    for (var i = 0; i < editQuestion.length; i++) {
      if (editQuestion[i] == '-') {
        setState(() {
          _operateSubtraction();
        });
        break;
      }
    }

    //break up numbers separated by +
    finalElements = editQuestion.split("+");

    //this helps with multiplicativeOperation that uses split(x), there needs to be an x
    for (var i = 0; i < finalElements.length; i++) {
      if (finalElements[i].contains('/')) {
        finalElements[i] = "1×" + finalElements[i];
      }
    }

    //if theres a x symbol, execute multiplication
    for (var i = 0; i < finalElements.length; i++) {
      if (finalElements[i].contains('×')) {
        setState(() {
          _operateMultiplication();
        });
        break;
      }
    }

    //if there exists a '+' sign, execute addition
    for (var i = 0; i < editQuestion.length; i++) {
      if (editQuestion[i] == '+') {
        setState(() {
          _operateAddition();
        });
        break;
      }
    }

    displayAnswer = answer.toString();

    if (displayAnswer.endsWith('.0')) {
      displayAnswer = displayAnswer.substring(0, displayAnswer.length - 2);
    }
  }

  void _operateAddition() {
    try {
      for (var i = 0; i < finalElements.length; i++) {
        answer = answer + double.parse(finalElements[i]);
      }
    } catch (e) {
      _displayError();
    }
  }

  //place a plus symbol infront of negative sign only if it doesn't have a sign before it
  void _operateSubtraction() {
    for (var i = 1; i < editQuestion.length; i++) {
      if (editQuestion[i] == '-' && !isOperator(editQuestion[i - 1])) {
        editQuestion = editQuestion.substring(0, i) +
            '+' +
            editQuestion.substring(i, editQuestion.length);
        i = i + 2;
      }
    }
  }

  static String _operateDivision(String abc) {
    double dividedResult;

    List<String> divisiveElements = abc.split("/");
    dividedResult =
        double.parse(divisiveElements[0]) / double.parse(divisiveElements[1]);

    if (divisiveElements.length > 2) {
      for (var k = 2; k < divisiveElements.length; k++) {
        dividedResult = dividedResult / double.parse(divisiveElements[k]);
      }
    }

    return dividedResult.toString();
  }

  void _operateMultiplication() {
    double multipliedResult;

    for (var i = 0; i < finalElements.length; i++) {
      if (finalElements[i].contains("×")) {
        List<String> multiplicativeElements = finalElements[i].split("×");

        //compute division first, then multiplication
        for (var k = 0; k < multiplicativeElements.length; k++) {
          if (multiplicativeElements[k].contains('/')) {
            multiplicativeElements[k] =
                _operateDivision(multiplicativeElements[k]);
          }
        }

        multipliedResult = double.parse(multiplicativeElements[0]) *
            double.parse(multiplicativeElements[1]);

        if (multiplicativeElements.length > 2) {
          for (var k = 2; k < multiplicativeElements.length; k++) {
            multipliedResult =
                multipliedResult * double.parse(multiplicativeElements[k]);
          }
        }

        finalElements[i] = multipliedResult.toString();
      }
    }
  }

  void _displayError() {
    setState(() {
      userQuestion = 'ERROR!';
      displayAnswer = '';
    });
  }

  bool startsWithNumber(String abc) {
    var x = abc[0];
    return RegExp(r'[0-9]').hasMatch(x);
  }

  bool isOperator(String abc) {
    var x = abc[0];
    return x == '+' || x == '-' || x == '×' || x == '/';
  }

  void _buttonPercent() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion += '%';
    });
  }

  // void _buttonDel() {
  //   if (userQuestion.length == 0) {
  //   } else {
  //     setState(() {
  //       userQuestion = userQuestion.substring(0, userQuestion.length - 1);
  //     });
  //   }
  // }

  void _buttonDel() {
    setState(() {
      userQuestion = userQuestion.isNotEmpty
          ? userQuestion.substring(0, userQuestion.length - 1)
          : userQuestion;
    });
  }

  void _buttonClr() {
    setState(() {
      userQuestion = '';
      displayAnswer = '';
    });
  }

  void _buttonOperator(String operator) {
    setState(() {
      if (displayAnswer.isNotEmpty) {
        _buttonClr();
      }
      userQuestion += operator;
    });
  }

  void _buttonDigit(String digit) {
    setState(() {
      if (displayAnswer.isNotEmpty) {
        _buttonClr();
      }
      userQuestion += digit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colourTheme[100],
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(height: 25),
              )
            ],
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  userQuestion,
                  style: TextStyle(fontSize: 50, color: colourTheme),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                displayAnswer,
                style: TextStyle(fontSize: 50, color: colourTheme),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          _buildFunctionButton(
                              'DEL', _buttonDel, Colors.red[400]!),
                          _buildFunctionButton(
                              'C', _buttonClr, Colors.green[400]!),
                          _buildFunctionButton(
                              '%', _buttonPercent, colourTheme[400]!),
                          _buildOperatorButton('÷', _buttonOperator),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          _buildDigitButton('7', _buttonDigit),
                          _buildDigitButton('8', _buttonDigit),
                          _buildDigitButton('9', _buttonDigit),
                          _buildOperatorButton('×', _buttonOperator),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          _buildDigitButton('4', _buttonDigit),
                          _buildDigitButton('5', _buttonDigit),
                          _buildDigitButton('6', _buttonDigit),
                          _buildOperatorButton('-', _buttonOperator),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          _buildDigitButton('1', _buttonDigit),
                          _buildDigitButton('2', _buttonDigit),
                          _buildDigitButton('3', _buttonDigit),
                          _buildOperatorButton('+', _buttonOperator),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          _buildDigitButton('0', _buttonDigit),
                          _buildDigitButton('.', _buttonDigit),
                          _buildDigitButton('ANS', _buttonDigit),
                          _buildFunctionButton(
                              '=', _buttonEqual, colourTheme[400]!),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 15,
              )
            ],
          )
        ],
      ),
    );
  }

  Expanded _buildFunctionButton(String text, Function() onTap, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildDigitButton(String digit, Function(String) onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () => onTap(digit),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: colourTheme[50],
              child: Center(
                child: Text(
                  digit,
                  style: TextStyle(fontSize: 30, color: colourTheme),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildOperatorButton(String operator, Function(String) onTap,
      {Color? color = null}) {
    color = color ?? colourTheme[400];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () => onTap(operator),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  operator,
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
