import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function(String id) _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text('No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                      onPressed: () =>
                          _deleteTransaction(transactions[index].id),
                    ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
