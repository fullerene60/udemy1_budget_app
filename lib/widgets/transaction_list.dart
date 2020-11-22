import 'package:flutter/material.dart';
import 'list_tile_options.dart';
import '../models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;
  final bool tileStyle;

  TransactionList({this.transactions, this.tileStyle, this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Text(
                    "Enter in a Transaction",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'lib/assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            }),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return ListTilePattern(
                index: index,
                transactions: transactions,
                toggle: tileStyle,
                removeTx: removeTransaction,
              );
            },
            itemCount: transactions.length,
          );
  }
}
