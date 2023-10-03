import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    )
  );
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});


  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

   // variables
  var input = '';
  var output = '';
  var operand = '';
  var hideInput = false;
  var outputSize = 34.0;


  onButtonClick(value) {
    if (value == 'C') {
      input = '';
      output = '';
    } else if (value == '←') {
      input = input.substring(0, input.length - 1);
    } else if (value == '+/-') {
        input.startsWith('-') ? input = input.substring(1) : input = '-' + input;
    } else if (value == '=') {
        var userInput = input;
        userInput = userInput.replaceAll('\u{00D7}', '*');
        userInput = userInput.replaceAll('\u{00F7}', '/');
        userInput = userInput.replaceAll('%', '/100');
        Parser p = Parser();
        Expression exp = p.parse(userInput);
        ContextModel cm = ContextModel();
        var eval = exp.evaluate(EvaluationType.REAL, cm);
        output = eval.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }

        input = output;
        hideInput = true;
        outputSize = 52.0;
    } else {
      input += value;
      hideInput = false;
      outputSize = 34.0;
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                  ),
                  SizedBox(height: 20,),
                  Text(output,
                  style: TextStyle(
                    fontSize: outputSize,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            )
            ),
            Row(
              children: [
                button(text: 'C', buttonBgColor: operatorColor, textColor: Colors.red),
                button(text: '←', buttonBgColor: operatorColor, textColor: greenColor),
                button(text: '%', buttonBgColor: operatorColor, textColor: greenColor),
                button(text: '\u{00F7}', buttonBgColor: operatorColor, textColor: greenColor)
              ],
            ),
            Row(
              children: [
                button(text: '7',),
                button(text: '8',),
                button(text: '9'),
                button(text: '\u{00D7}', buttonBgColor: operatorColor, textColor: greenColor)
              ],
            ),
            Row(
              children: [
                button(text: '4',),
                button(text: '5',),
                button(text: '6'),
                button(text: '-', buttonBgColor: operatorColor, textColor: greenColor)
              ],
            ),
            Row(
              children: [
                button(text: '1',),
                button(text: '2',),
                button(text: '3'),
                button(text: '+', buttonBgColor: operatorColor, textColor: greenColor)
              ],
            ),
            Row(
              children: [
                button(text: '+/-', textColor: greenColor, buttonBgColor: operatorColor),
                button(text: '0',),
                button(text: '.'),
                button(text: '=', buttonBgColor: greenColor)
              ],
            )
        ],
      ),
    );
  }

  Widget button({required text, buttonBgColor = buttonColor, textColor = Colors.white}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            padding: EdgeInsets.all(22),
            backgroundColor: buttonBgColor,
          ),
          onPressed: () {
            onButtonClick(text);
          },
          child: Text(text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),)
          ),
      ),
        );
  }

}


