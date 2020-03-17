import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Bruno Petrolini",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Rua Carlito Messias da Silva",
                style: TextStyle(fontWeight: FontWeight.w100),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("P. Produtos"),
            Text("P. Total"),
          ],
        )
      ],
    );
  }
}
