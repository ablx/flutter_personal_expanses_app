import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(222, 222, 222, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1)),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfTotal,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ]),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
