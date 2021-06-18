import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_testt/TransacionList.dart';
import 'package:flutter_app_testt/transaction.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Transaction _transaction = Transaction(content: '', amount: 0.0);
  List<Transaction> _transactions = List<Transaction>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _insertTransaction() {
    if (_transaction.content.isEmpty ||
        _transaction.amount == 0.0 ||
        _transaction.amount.isNaN) {
      return;
    }
    _transaction.createdDate = DateTime.now();
    _transactions.add(_transaction);
    _transaction = Transaction(content: '', amount: 0.0);
    _contentController.text = '';
    _amountController.text = '';
  }

  void _showButtomShet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Column(
            children: [
              TextField(
                onChanged: (text) {
                  setState(() {
                    _transaction.content = text;
                  });
                },
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
              ),
              TextField(
                onChanged: (text) {
                  setState(() {
                    _transaction.amount = double.tryParse(text) ?? 0;
                  });
                },
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    this._insertTransaction();
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đây là màn của tôi '),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  this._insertTransaction();
                });
                print('bạn đã click vào add');
              })
        ],
      ),
      key: _scaffoldkey,
      body: SafeArea(
        minimum: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                height: 40,
                child: FlatButton(
                  onPressed: () {
                    this._showButtomShet();
                  },
                  child: Text(
                    'Insert',
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: Colors.white,
                  color: Colors.pinkAccent,
                ),
              ),
              TransactionList(transactions: _transactions)
            ],
          ),
        ),
      ),
    );
  }
}
