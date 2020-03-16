import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;

  UserTile({@required this.user});

  @override
  Widget build(BuildContext context) {
    if (user.containsKey("spent")) {
      return ListTile(
        title: Text(
          user["name"],
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          user["email"],
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pedidos: ${user["orders"]}",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "T. Gasto: R\$${user["spent"].toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 20,
              child: Shimmer.fromColors(
                child: Container(
                  color: Colors.white.withAlpha(50),
                  margin: EdgeInsets.symmetric(vertical: 4),
                ),
                baseColor: Colors.white,
                highlightColor: Colors.grey,
              ),
            ),
            SizedBox(
              width: 50,
              height: 20,
              child: Shimmer.fromColors(
                child: Container(
                  color: Colors.white.withAlpha(50),
                  margin: EdgeInsets.symmetric(vertical: 4),
                ),
                baseColor: Colors.white,
                highlightColor: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
  }
}
