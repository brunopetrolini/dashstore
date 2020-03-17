import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashstore/widgets/order_header.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot order;

  OrderTile({@required this.order});

  final status = ["", "Preparação", "Transporte", "Entrege"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#${order.documentID} - ${status[order.data["status"]]}",
            style: TextStyle(
                color: order.data["status"] != 4
                    ? Colors.grey[850]
                    : Colors.green),
          ),
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: order.data["products"].map<Widget>((product) {
                        return ListTile(
                          title: Text(product["product"]["title"] +
                              " " +
                              product["size"]),
                          subtitle:
                              Text(product["category"] + "/" + product["pid"]),
                          trailing: Text(
                            product["quantity"].toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          contentPadding: EdgeInsets.zero,
                        );
                      })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Text("Excluir"),
                        textColor: Colors.red,
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text("Regredir"),
                        textColor: Colors.grey[850],
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text("Avançar"),
                        textColor: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
