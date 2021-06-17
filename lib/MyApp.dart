import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildWidgetList(){
      int index = 0;
      return  _transactions.map((eachTransaction){
        index++;
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: index % 2 == 0 ? Colors.green : Colors.teal,
          elevation: 10,
          child: ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text(eachTransaction.content,style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
            subtitle: Text('price: ${eachTransaction.amount}',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
            ),),
            onTap: (){
              print('Bạn vừa chọn ${eachTransaction.content}');
            },
          ),
        );
      }).toList();
    }
    return MaterialApp(
      title: 'Đây là app đầu tiên của tôi',
      home: Scaffold(
        key: _scaffoldkey,
        body: SafeArea(
          minimum: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
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
              SizedBox(height: 20,),
              ButtonTheme(
                height: 40,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _transactions.add(_transaction);
                      _transaction = Transaction(content: '',amount: 0.0);
                      _contentController.text = '';
                      _amountController.text = '';
                    });
                    _scaffoldkey.currentState.showSnackBar(SnackBar(
                      content: Text(
                          'Transaction List: ' + _transaction.toString()),
                      duration: Duration(seconds: 3),
                    ));
                  },
                  child: Text('Insert',style: TextStyle(fontSize: 18),),
                  textColor: Colors.white,
                  color: Colors.pinkAccent,
                ),
              ),
              Column(
                children:_buildWidgetList()
              )
            ],
          ),
        ),
      ),
    );
  }
}
