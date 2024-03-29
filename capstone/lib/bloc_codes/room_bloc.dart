import 'dart:async';
import 'package:capstone/bloc_codes/personal_chat.dart';
import 'package:capstone/chat_room_codes/users_Info_communicator.dart';
import 'package:capstone/chat_room_codes/chatting_room.dart';
import 'package:flutter/material.dart';
import 'package:capstone/feed_page_codes/room_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:capstone/fire_base_codes/fire_store_provider.dart';

class RoomBloc extends Object{
  BuildContext _context ;
  final _roomPressed = StreamController<int>.broadcast() ;
  final _addedRoom = StreamController<RoomInfo>.broadcast() ;
  final _roomFinding = StreamController<RoomInfo>.broadcast() ;
  final _isRoomFinding = StreamController<bool>.broadcast() ;
  final _roomEntering = StreamController<RoomInfo>.broadcast() ;
  final _isRoomEntered = StreamController<BuildContext>.broadcast() ;
  final _roomMessages = FirestoreProvider().getRoomMessages;
  final _chatRoomList = FirestoreProvider().chatRoomList ;
  final _feedRoomList = FirestoreProvider().feedRoomList;
  final _getRoomSnapshot = FirestoreProvider().getRoomSnapshot;
  final _didGetUserSnapshot = StreamController<bool>.broadcast() ;
  final _didGetFriendsSnapshot = StreamController<bool>.broadcast() ;
  final _personalChat = StreamController<List<dynamic>>.broadcast() ;
  final _personalRoomMessages = FirestoreProvider().getPersonalRoomMessages ;

  RoomInfo feedPageRoomInfo;
  RoomInfo chatRoomInfo;
  String personalChatOpponent ;


  Stream<int> get roomPressed => _roomPressed.stream ;
  Stream<RoomInfo> get addedRoom => _addedRoom.stream ;
  Stream<RoomInfo> get roomFinding => _roomFinding.stream ;
  Stream<bool> get isRoomFinding => _isRoomFinding.stream ;
  Stream<RoomInfo> get roomEntering => _roomEntering.stream ;
  Stream<BuildContext> get isRoomEntered => _isRoomEntered.stream ;
  Stream<QuerySnapshot> get roomMessages => _roomMessages(chatRoomInfo) ;
  Stream<QuerySnapshot> get roomList => _feedRoomList(feedPageRoomInfo) ;
  Stream<QuerySnapshot> get chatRoomList => _chatRoomList() ;
  Stream<DocumentSnapshot> get getRoomSnapshot => _getRoomSnapshot(chatRoomInfo) ;
  Stream<bool> get didGetUserSnapshot => _didGetUserSnapshot.stream ;
  Stream<bool> get didGetFriendsSnapshot => _didGetFriendsSnapshot.stream ;
  Stream<List<dynamic>> get personalChatOpen => _personalChat.stream ;
  Stream<QuerySnapshot> get personalRoomMessages => _personalRoomMessages(personalChatOpponent) ;
  
  Function(int) get setRoomPressed => _roomPressed.sink.add ;
  Function(RoomInfo) get setRoomFinding => _roomFinding.sink.add ;
  Function(RoomInfo) get setRoomEntering => _roomEntering.sink.add ;
  Function(bool) get setIsRoomFinding => _isRoomFinding.sink.add ;
  Function(BuildContext) get setIsRoomEntered => _isRoomEntered.sink.add ;
  Function(bool) get setDidGetUserSnapshot => _didGetUserSnapshot.sink.add ;
  Function(bool) get setDidGetFriendsSnapshot => _didGetFriendsSnapshot.sink.add ;
  Function(RoomInfo) get registerRoom => FirestoreProvider().registerRoom;
  Function(RoomInfo) get addUserInRoom => FirestoreProvider().addUserInRoom;
  Function(RoomInfo, String) get sendMessage => FirestoreProvider().sendMessage ;
  Function(RoomInfo) get exitRoom => FirestoreProvider().exitRoom ;
  Function(List<dynamic>) get personalChat => _personalChat.sink.add ;
  Function(String, String) get sendMessagePersonal => FirestoreProvider().sendMessagePersonal ;

  RoomBloc(){
    personalChatOpen.listen((List<dynamic> list){
      personalChatOpponent = list.elementAt(1) ;
      Navigator.push(list.elementAt(0), MaterialPageRoute(
          builder: (context) => PersonalChatRoom(list.elementAt(1))
      )) ;
    },onError: (error) {
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text("Error!"),
      )
      ) ;
    }) ;

    roomEntering.listen((RoomInfo roomInfo){
      chatRoomInfo = roomInfo ;
    },onError: (error) {
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text("Error!"),
      )
      ) ;
    }
    );

    isRoomEntered.listen((BuildContext context){
      UsersInfoCommunicator.roomInfo = chatRoomInfo ;
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => ChatRoom(chatRoomInfo)
      )) ;
    },onError: (error) {
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text("Error!"),
      )
      ) ;
    }) ;

    roomFinding.listen((RoomInfo roomInfo){
      feedPageRoomInfo = roomInfo;
    },onError: (error) {
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text("Error!"),
      )
      ) ;
    }
    );
  }

  dispose(){
    _roomPressed.close() ;
    _addedRoom.close() ;
    _roomFinding.close() ;
    _roomEntering.close() ;
    _isRoomFinding.close() ;
    _isRoomEntered.close() ;
    _didGetUserSnapshot.close() ;
    _didGetFriendsSnapshot.close() ;
    _personalChat.close() ;
  }

}