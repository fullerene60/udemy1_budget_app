import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy1_budget_app/models/Transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    // getters are dynamically created functions with properties, they stay private to a class annd to no take arguments
    return List.generate(7, (index) {
      double totalSum = 0.0;
      final weekDay = DateTime.now().subtract(Duration(days: index));

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum
      };
    });
  }

  double get weeklySpendingTotal {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    }); //a fold method changes a list to another type with some contained logic, in javascript this is called reduced
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: groupedTransactionValues.reversed
                      .map((data) => ChartBar(
                            label: data['day'],
                            spendingAmount: data['amount'],
                            spendingPercentage: weeklySpendingTotal == 0.0
                                ? 0.0
                                : (data['amount'] as double) /
                                    weeklySpendingTotal,
                          ))
                      .toList()),
            ),
          ],
        ));
  }
}
