import 'dart:async';
import 'package:flutter/material.dart';
import 'package:capstone/feed_page_codes/room_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:capstone/fire_base_codes/fire_store_provider.dart';

class RoomBloc extends Object{

  //FirestoreProvider는 계속 생성? or variable 만들어서 ..?

  BuildContext _context ;
  final _roomPressed = StreamController<int>.broadcast() ;
  final _initRooms = StreamController<bool>.broadcast() ;
  final _scrollRooms = StreamController<bool>.broadcast() ;
  final _addedRoom = StreamController<RoomInfo>.broadcast() ;
  final _roomList = FirestoreProvider().roomList;
  final _roomFinding = StreamController<RoomInfo>.broadcast() ;
  final _isRoomFinding = StreamController<bool>.broadcast() ;
  final _roomEntering = StreamController<RoomInfo>.broadcast() ;
  final _isRoomEntered = StreamController<bool>.broadcast() ;
  final _roomMessages = FirestoreProvider().getRoomMessages;
  
  RoomInfo feedPageRoomInfo;
  RoomInfo chatRoomInfo;

  Stream<int> get roomPressed => _roomPressed.stream ;
  Stream<bool> get initRooms => _initRooms.stream ;
  Stream<bool> get scrollRooms => _scrollRooms.stream ;
  Stream<bool> get isRoomFinding => _isRoomFinding.stream ;
  Stream<bool> get isRoomEntered => _isRoomEntered.stream ;
  Stream<RoomInfo> get addedRoom => _addedRoom.stream ;
  Stream<QuerySnapshot> get roomList => _roomList(feedPageRoomInfo) ;
  Stream<RoomInfo> get roomFinding => _roomFinding.stream ;
  Stream<RoomInfo> get roomEntering => _roomEntering.stream ;
  Stream<QuerySnapshot> get roomMessages => _roomMessages(chatRoomInfo) ;
/*
searching stream 만들어서 searching block icon 눌렸을 때 list block stream 바꿔줌
 */

  Function(int) get setRoomPressed => _roomPressed.sink.add ;
  Function(bool) get setInitRooms => _initRooms.sink.add ;
  Function(bool) get setScrollRooms => _scrollRooms.sink.add ;
  Function(RoomInfo) get registerRoom => FirestoreProvider().registerRoom;
  Function(RoomInfo) get setRoomFinding => _roomFinding.sink.add ;
  Function(RoomInfo) get setRoomEntering => _roomEntering.sink.add ;
  Function(bool) get setIsRoomFinding => _isRoomFinding.sink.add ;
  Function(bool) get setIsRoomEntered => _isRoomEntered.sink.add ;


  RoomBloc(){
    roomEntering.listen((RoomInfo roomInfo){
      print('here is enterRoom.listen ${roomInfo.roomName}') ;
      chatRoomInfo = roomInfo ;
    },onError: (error) {
      print("enter Room error occured");
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text("Error!"),
      )
      ) ;
    }
    );

    isRoomEntered.listen((bool value){
      print('here is isRoomEntered.listen') ;
    },onError: (error) {
      print("enter Room error occured");
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text("Error!"),
      )
      ) ;
    }) ;

    roomFinding.listen((RoomInfo roomInfo){
      print('here is roomFinding.listen ${roomInfo.roomName}') ;
      feedPageRoomInfo = roomInfo;
    },onError: (error) {
      print("room finding error occured");
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text("Error!"),
      )
      ) ;
    }
    );
  }

  dispose(){
    _roomPressed.close() ;
    _initRooms.close() ;
    _scrollRooms.close() ;
    _addedRoom.close() ;
    _roomFinding.close() ;
    _roomEntering.close() ;
    _isRoomFinding.close() ;
    _isRoomEntered.close() ;
  }

}