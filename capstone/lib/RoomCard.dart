import 'package:capstone/ChatRoom.dart';
import 'package:flutter/material.dart';
//import 'ProfilePage.dart' ;
import 'package:capstone/DetailPage.dart';
/*
* 이미지 UI 그리는 부분 수정 필요
 */

class RoomCard extends StatefulWidget{
  final ChatRoom chatroom ;

  RoomCard(this.chatroom) ;

  @override
  RoomCardState createState() => new RoomCardState(chatroom, this);
}


class RoomCardState extends State<RoomCard> {

  ChatRoom chatRoom ;
  RoomCard roomCardForDetail ;
  RoomCardState(this.chatRoom, this.roomCardForDetail) ;

  void initState(){
    super.initState() ;
  }

  Widget get roomImage {


    var roomAvatar = new Hero(
      tag: chatRoom,
//      child: new CircleAvatar(
//        radius: 30,
////        backgroundImage: AssetImage('Images/sample.png'),
        child: new Container(
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('Images/sample.png'),
            ),
          ),
        ),
//      )
    );

    var placeholder = new Container(
        width: 50.0,
        height: 50.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
          ),
        ),
        alignment: Alignment.center,
        child: new Text(
          'Room',
          textAlign: TextAlign.center,
        )
    );

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: roomAvatar,
      crossFadeState: 1 == 2
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  Widget get roomCard {
    return new Container(
      //  tag: roomCard,
      width: 390,
      height: 125.0,
      child: new Card(
        elevation: 3,
        color: Colors.white,
        child: new Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 20.0,
          ),
          child: new Row(
              children: <Widget>[
                roomImage,
                new Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  )),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    //Title
                    new Text(widget.chatroom.roomName,

                      style: Theme.of(context).textTheme.headline,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                    ),
                    //day and time
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.calendar_today, size: 12),
                        new Text(' ${widget.chatroom.date}', //String 안에서 변수를 사용할 때는 이런식으로 써요
                          style: Theme.of(context).textTheme.body1
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                        ),
                        new Icon(Icons.access_time, size: 12),
                        new Text('${widget.chatroom.time}', //String 안에서 변수를 사용할 때는 이런식으로 써요
                          style: Theme.of(context).textTheme.body1
                        ),
                      ]
                    ),

                    //Location
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.location_on, size: 12),
                        new Text('경상북도 포항시 북구 흥해읍', //String 안에서 변수를 사용할 때는 이런식으로 써요
                          style: Theme.of(context).textTheme.body1
                        ),
                      ],
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(
                        top: 7,
                      ),
                    ),

                    //People counts
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.people, size: 15),
                        new Text(': ${widget.chatroom.currentPeopleNumbers} / ${widget.chatroom.fullPeopleNumbers}')
                      ],
                    )
                  ],
                ),
              ]

          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showRoomDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        child: new Container(
          height: 125.0,
          child: roomCard,
        ),
      ),
    );
  }



  showRoomDetailPage() {
//    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//      return DetailPage(chatRoom);
//    }));

    return showDialog(
        context: context,
        builder: (BuildContext context){
          return DetailPage(chatRoom, roomCard) ;
        }
    );

  }







}