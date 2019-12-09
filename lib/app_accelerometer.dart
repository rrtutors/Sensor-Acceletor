import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class AppAcceletor extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppAcceletorState();
  }


}

class AppAcceletorState extends State<AppAcceletor>{
int user=1;
int score=0;
int user1_score=0;
int user2_score=0;
var rng;
bool isShowing;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=1;
     rng = new Random();
    isShowing=false;
    accelerometerEvents.listen((AccelerometerEvent event){
      int value=18;
      if (event.x >= value ||
          event.x <= -value ||
          event.y >= value ||
          event.y <= -value ||
          event.z >= value ||
          event.z <= -value) {
        if (isShowing == false) {
          isShowing=true;
          score = rng.nextInt(6);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("User $user"),
                content: new Text("$score Points "),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Next"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      //updatescore();
                    },
                  ),
                ],
              );
            },
          ).then((value) {
            updatescore();
          });
        }
      }
    });
  }
  updatescore()
  {
    isShowing=false;
    if (user == 1) {
      if (user1_score + score >= 20) {
        gameEnd(1);
      }else
        {
          setState(() {
            user1_score = user1_score + score;

            user = 2;
          });
        }
    }else if(user==2)
      {
        if (user2_score + score >= 20) {
          gameEnd(2);
        }else
        {
          setState(() {
            user2_score = user2_score + score;

            user = 1;
          });
        }
      }


  }

  gameEnd(w)
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Game Finished"),
          content: new Text("User  $w won the game "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Restart Game"),
              onPressed: () {
                Navigator.of(context).pop();

                //updatescore();
              },
            ),
          ],
        );
      },
    ).then((value) {
      setState(() {
        user=w;
        user1_score=0;
        user2_score=0;
        score=0;
        isShowing=false;

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Game with AcceleroMeter Sensor"),
      ),
      body:Flex(direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.grey,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  right: 10,
                  child: Text("User 1 ",style: TextStyle(color: Colors.pink,fontSize: 30),),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Visibility(
                    child: /*Icon(Icons.camera,color: Colors.pink,size: 40,)*/Image.asset("assets/die_2.png",height: 40,width: 40,),
                    visible: (user==1)?true:false,
                  ),
                ),
                Center(
                  child:  Text("Score $user1_score",style: TextStyle(color: Colors.pink,fontSize: 30),),
                )
              ],
            ),
          ),
        )
         ,
        Expanded(
          child: Container(
            color: Colors.brown,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  right: 10,
                  child: Text("User 2 ",style: TextStyle(color: Colors.green,fontSize: 30),),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Visibility(
                    child: Image.asset("assets/die_2.png",height: 40,width: 40,),
                    visible: (user==2)?true:false,
                  ),
                ),
                Center(
                  child:  Text("Score $user2_score",style: TextStyle(color: Colors.green,fontSize: 30),),
                )
              ],
            ),
          ),
        )

        ],
      )

    );
  }

}