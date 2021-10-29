import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        home: MyHomePage(),
        theme: ThemeData(
            fontFamily: 'Quicksand',
            textTheme: TextTheme(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)));
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries1',
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries2',
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Grocerie3',
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries4',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries5',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries6',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Old Groceries',
      amount: 6.53,
      date: DateTime.now().subtract(Duration(days: 8)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
            (e) => e.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  bool _showChart = false;

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return new GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Flutter App'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    var taList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.8,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Show Chart'),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ]),
            if (!isLandscape)
              Container(
                width: double.infinity,
                child: Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(_recentTransactions)),
              ),
            if (!isLandscape) taList,
            if (isLandscape)
              _showChart
                  ? Container(
                      width: double.infinity,
                      child: Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.8,
                          child: Chart(_recentTransactions)),
                    )
                  : taList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
