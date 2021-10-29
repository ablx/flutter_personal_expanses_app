import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(height: 4),
          Container(
            height: constraint.maxHeight * 0.5,
            width: 10,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        width: 1)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ]),
          ),
          SizedBox(height: 4),
          Container(height: constraint.maxHeight * 0.15, child: Text(label)),
        ],
      );
    });
  }
}
