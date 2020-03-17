import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashstore/blocs/user_bloc.dart';
import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  final DocumentSnapshot order;

  OrderHeader({@required this.order});

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _userBloc.getUsers(order["clientID"])["name"],
                style: TextStyle(fontSize: 16),
              ),
              Text(
                _userBloc.getUsers(order["clientID"])["address"],
                style: TextStyle(fontWeight: FontWeight.w100),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
                "T. Prod: R\$${order.data["productsPrice"].toStringAsFixed(2)}"),
            Text("Total: R\$${order.data["totalPrice"].toStringAsFixed(2)}"),
          ],
        )
      ],
    );
  }
}
