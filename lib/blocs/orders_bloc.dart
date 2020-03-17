import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';

enum SortCriterion { READY_FIRST, READY_LAST }

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();

  Stream<List> get outOrders => _ordersController.stream;

  Firestore _firestore = Firestore.instance;

  List<DocumentSnapshot> _orders = [];

  SortCriterion _criterion;

  OrdersBloc() {
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection("orders").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String oid = change.document.documentID;

        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.document);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.documentID == oid);
            _orders.add(change.document);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.documentID == oid);
            break;
        }
      });

      _ordersController.add(_orders);
    });
  }

  void setOrderCreterion(SortCriterion criterion) {
    _criterion = criterion;

    _sort();
  }

  void _sort() {
    switch (_criterion) {
      case SortCriterion.READY_FIRST:
        _orders.sort((a, b) {});
      case SortCriterion.READY_LAST:
    }
  }

  @override
  void dispose() {
    _ordersController.close();
  }
}
