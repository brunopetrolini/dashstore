import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dashstore/blocs/orders_bloc.dart';
import 'package:dashstore/blocs/user_bloc.dart';
import 'package:dashstore/tabs/orders_tab.dart';
import 'package:dashstore/tabs/users_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  UserBloc _userBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(
                  color: Colors.white54,
                ),
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (page) {
            _pageController.animateToPage(page,
                duration: Duration(milliseconds: 250), curve: Curves.ease);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Clientes"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Pedidos"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Produtos"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc>(
            bloc: _ordersBloc,
            child: PageView(
              onPageChanged: (page) {
                setState(() {
                  _page = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                UsersTab(),
                OrdersTab(),
                Container(color: Colors.green),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _floatingButton() {
    switch (_page) {
      case 1:
        return SpeedDial(
          child: Icon(Icons.sort),
          backgroundColor: Theme.of(context).primaryColor,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.arrow_downward,
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Colors.white,
              label: "Concluídos Abaixo",
              onTap: () =>
                  _ordersBloc.setOrderCreterion(SortCriterion.READY_LAST),
            ),
            SpeedDialChild(
              child: Icon(
                Icons.arrow_upward,
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Colors.white,
              label: "Concluídos Acima",
              onTap: () =>
                  _ordersBloc.setOrderCreterion(SortCriterion.READY_FIRST),
            ),
          ],
        );
      default:
        return null;
    }
  }
}
