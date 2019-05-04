import 'package:capstone/bottom_navigation.dart';
import 'package:capstone/main.dart';
import 'package:flutter/material.dart' ;
import 'dart:async';

class BottomBarBloc extends Object{

  BuildContext _context ;

  final _bottomBarPressed = StreamController<int>.broadcast() ;

  Stream<int> get bottomBarPressed => _bottomBarPressed.stream ;

  Function(int) get setBottomBarPressed => _bottomBarPressed.sink.add ;

  BottomBarBloc(){
    bottomBarPressed.listen((int index) {
      print('here is bottomBarPressed.listen') ;
      MyApp.botNavBar.animate(index) ;
//      BottomNavigation().animate(index) ;
      }
    ,onError: (error) {
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text(error.message),
      ));
    });
  }

  dispose(){
    _bottomBarPressed.close() ;
  }

}