import 'package:flutter/material.dart';
import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';
import 'models/Transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  // //Needed to set preffered device orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // //From the services package, allows you to set system wide settings in the app
  // //Forces the app to only be in portait mode and not landscape mode
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        errorColor: Colors.redAccent,
        primarySwatch: Colors.cyan,
        accentColor: Colors.brown[100],
        fontFamily: "Quicksand",
        textTheme: ThemeData.light()
            .textTheme
            .copyWith(button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Purchases',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool tyleStyle = true;
  bool _showChart = false;

  final List<Transaction> _userTransactions = [
    Transaction(
        title: "Car Insurance",
        amount: 43.22,
        date: DateTime.now().subtract(Duration(days: 2)),
        id: "test1"),
    Transaction(
        title: "Penguin",
        amount: 5.00,
        date: DateTime.now().subtract(Duration(days: 3)),
        id: "test2"),
    Transaction(
        title: "Burger",
        amount: 8.95,
        date: DateTime.now().subtract(Duration(days: 4)),
        id: "test3"),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var appBar = AppBar(
      title: Text(
        'Purchases',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => _startNewTransaction(context)),
        IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                tyleStyle == true ? tyleStyle = false : tyleStyle = true;
              });
            })
      ],
    );

    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        tileStyle: tyleStyle,
        removeTransaction: _deleteTransaction,
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startNewTransaction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Some crazy fucking dart/java syntax that lets you place conditions on whether an element will exist within a list, fucking love it!
          if (isLandscape)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.05,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Show Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ]),
            ),
          if (!isLandscape)
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.25,
                child: Chart(_recentTransactions)),

          if (isLandscape)
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.25,
                    child: Chart(_recentTransactions))
                : Container(),
          txList
        ],
      ),
    );
  }
}
