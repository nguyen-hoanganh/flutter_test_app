import 'package:flutter/material.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;

  TransactionList({this.transactions});

  List<Widget> _buildWidgetList() {
    int index = 0;
    return transactions.map((eachTransaction) {
      index++;
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: index % 2 == 0 ? Colors.green : Colors.teal,
        elevation: 10,
        child: ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text(
            eachTransaction.content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'price: ${eachTransaction.amount}',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          onTap: () {
            print('Bạn vừa chọn ${eachTransaction.content}');
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: this._buildWidgetList());
  }
}
