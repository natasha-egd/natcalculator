import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _displayController = TextEditingController();
  String _expression = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
      } else if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _expression = '$_expression = $result';
        } catch (e) {
          _expression = 'Error';
        }
      } else {
        _expression += value;
      }
      _displayController.text = _expression;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Copilot Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _displayController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              style: TextStyle(fontSize: 24),
              readOnly: true,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  _buildButton('7'), _buildButton('8'), _buildButton('9'), _buildButton('/'),
                  _buildButton('4'), _buildButton('5'), _buildButton('6'), _buildButton('*'),
                  _buildButton('1'), _buildButton('2'), _buildButton('3'), _buildButton('-'),
                  _buildButton('0'), _buildButton('C'), _buildButton('='), _buildButton('+'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(value),
      child: Text(value, style: TextStyle(fontSize: 24)),
    );
  }
}