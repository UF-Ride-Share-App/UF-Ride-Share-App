import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final Function(int) onChanged;

  Counter({this.minValue, this.maxValue, this.onChanged});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
          child: Icon(Icons.remove_circle, color: Colors.teal[700]),
          onPressed: () {
            if (count - 1 >= this.widget.minValue) setState(() => count--);
            this.widget.onChanged(count);
          }),
        Text('$count', style: TextStyle(fontSize: 20)),
        MaterialButton(
          child: Icon(Icons.add_circle, color: Colors.teal[700]),
          onPressed: () {
            if (count + 1 <= this.widget.maxValue) setState(() => count++);
            this.widget.onChanged(count);
          })
      ],
    );
  }
}
