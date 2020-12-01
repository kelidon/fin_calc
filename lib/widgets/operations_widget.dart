import 'package:fin_calc/utils/calculator_util.dart';
import 'package:fin_calc/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';

class OperationsWidget extends StatelessWidget {
  final int blocOperationIndex;

  const OperationsWidget({Key key, this.blocOperationIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonWidget(
              operation: Operations.ADD,
              blocOperationIndex: blocOperationIndex,
            ),
            SizedBox(
              width: 20,
            ),
            ButtonWidget(
              operation: Operations.DISTRACT,
              blocOperationIndex: blocOperationIndex,
            ),
            SizedBox(
              width: 20,
            ),
            ButtonWidget(
              operation: Operations.MULTIPLY,
              blocOperationIndex: blocOperationIndex,
            ),
            SizedBox(
              width: 20,
            ),
            ButtonWidget(
              operation: Operations.DIVIDE,
              blocOperationIndex: blocOperationIndex,
            ),
          ]),
    );
  }
}
