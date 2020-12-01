import 'package:flutter/cupertino.dart';

class OutputWidget extends StatelessWidget{
  final String text;

  const OutputWidget({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFFCCCCCC),
        borderRadius:
        BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        text,
        style: TextStyle(height: 1.5),
      ),
    );
  }

}
