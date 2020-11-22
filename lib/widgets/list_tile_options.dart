import 'package:flutter/material.dart';
import 'package:udemy1_budget_app/models/Transaction.dart';
import 'package:intl/intl.dart';

class ListTilePattern extends StatelessWidget {
  final bool toggle;
  final List<Transaction> transactions;
  final int index;
  final Function removeTx;
  ListTilePattern({this.transactions, this.index, this.toggle, this.removeTx});

  @override
  Widget build(BuildContext context) {
    return toggle
        ? Card(
            margin: EdgeInsets.all(6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                      child: Text(
                    '\$${transactions[index].amount}',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                  '${DateFormat.yMMMd().format(transactions[index].date)}'),
              trailing: MediaQuery.of(context).size.width > 360
                  ? FlatButton.icon(
                      textColor: Theme.of(context).errorColor,
                      onPressed: () => removeTx(transactions[index].id),
                      icon: Icon(Icons.delete),
                      label: Text('Delete'))
                  : IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removeTx(transactions[index].id),
                      color: Theme.of(context).errorColor,
                    ),
            ),
          )
        : Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                      width: 1.8,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${transactions[index].amount}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transactions[index].title,
                        style: TextStyle(
                            fontFamily: "Quicksand",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                      Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeTx(transactions[index].id),
                  color: Theme.of(context).errorColor,
                )
              ],
            ),
          );
  }
}
