
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'audio/audio_play.dart';
import 'library_activity.dart';

class DashBoardActivity extends StatefulWidget {
  const DashBoardActivity({Key? key}) : super(key: key);

  @override
  State<DashBoardActivity> createState() => _DashBoardActivityState();
}

class _DashBoardActivityState extends State<DashBoardActivity> {
  List<Books> list =[
    Books("https://cdn.hackr.io/uploads/posts/attachments/16431216080SuUqgLuUG.png"),
    Books("https://static.kopykitab.com/image/cache/data/faculty-notes/504098-300x380.jpg"),
    Books( "https://snatchbooks.com/wp-content/uploads/2020/10/Computer-System-Architecture-300x360.jpg"),
    Books("https://m.media-amazon.com/images/I/91ctlaHQLyL._AC_UF1000,1000_QL80_.jpg"),
    Books("https://cdn.hackr.io/uploads/posts/attachments/16431217469xj1pvxhms.png"),
    Books( "https://m.media-amazon.com/images/I/71uYIOC2mNS._AC_UF1000,1000_QL80_.jpg"),
    Books( "https://qph.cf2.quoracdn.net/main-qimg-4d98cb84e44ddfb3160ed36e52d014e6-lq"),
  ];
  var lightBlue1 =Color(int.parse("0xff0295eb"));
  var lightBlue2 =Color(int.parse("0xff03b3ed"));
  var blue =Color(int.parse("0xff03b3ed"));
  navigate(){
    Navigator.of(context).pushNamed("/description");
  }
  Widget uiScreen(){
    return Container(
      margin: EdgeInsets.only(top: 30),
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [lightBlue1, lightBlue2],
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
      children: [
             Container(
               margin: EdgeInsets.only(left: 10,right: 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Gayaratham",style: TextStyle(fontSize: 20,color: Colors.white),),
                   SizedBox(height: 10,),
                   Row(
                     children: [
                       Icon(Icons.notifications_sharp,color: Colors.white,),
                       SizedBox(width: 5,),
                       Icon(Icons.settings,color: Colors.white,),
                       SizedBox(width: 5,),
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage("https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg?w=2000"),
                      ),
                       SizedBox(width: 5,),

                     ],
                   )
                 ],
               ),
             ),
        Container(
            height: MediaQuery.of(context).size.height*0.3,
            color: blue,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                // Flexible(child: Image.network("https://m.media-amazon.com/images/I/51CfPrmQR8L._AC_UF1000,1000_QL80_.jpg",placeholder: (context, url) =>
                //     CircularProgressIndicator(),  )),

                Flexible(child:  CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "https://m.media-amazon.com/images/I/51CfPrmQR8L._AC_UF1000,1000_QL80_.jpg",
                  placeholder: (context, url) =>Center(child: CircularProgressIndicator(),),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error), )),
                Flexible(child: Container(
                  //color: Colors.red,
                  margin: EdgeInsets.all(10),
                  child: Column(
                  mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text("Continue Reading",style: TextStyle(color: Colors.white,fontSize: 22),),
                       InkWell(
                         onTap: (){
                           const prefix = 'https://www.soundhelix.com/examples/mp3';
                           final song1 = '$prefix/SoundHelix-Song-1.mp3';
                           AudioControlButtons.addSongs(song1);
                         },
                         child: Container(
                           decoration: BoxDecoration(
                               color: Colors.white,
                               shape: BoxShape.circle
                           ),
                           child: Icon(Icons.play_arrow,color: Colors.black,),
                         ),
                       )

                    ],
                  ),
                ))
              ],
            ),
        ),
        SizedBox(height: 20,),
        Text("Your Liabray",style: TextStyle(fontSize: 20,color: Colors.white),),
        SizedBox(height: 20,),
        SizedBox(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (ctx,value){
              return InkWell(
                onTap: (){
                  navigate();
                },
                child: Container(
                    margin: EdgeInsets.all(5),
                    child: Image.network(list[value].url,width: 100,height: 100,)),
              );
            }),
        ),
        SizedBox(height: 20,),
        Text("My Download Request",style: TextStyle(fontSize: 20,color: Colors.white),),
        SizedBox(height: 20,),
        SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx,value){
                  return InkWell(
                    onTap: (){
                      //navigate();
                      Navigator.of(context).pushNamed("/request_description");
                    },
                    child: Container(
                        margin: EdgeInsets.all(5),
                        child: Image.network(list[value].url,width: 100,height: 100,)),
                  );
                }),
        )
      ],
    ),
          ),
        )

    );
    // return Column(
    //   children: [
    //      Row(
    //        children: [
    //          Text("Gayaratham"),
    //          Row(
    //            children: [
    //              Icon(Icons.notifications_sharp,color: Colors.white,),
    //              Icon(Icons.notifications_sharp,color: Colors.white,),
    //             CircleAvatar(
    //               radius: 10,
    //               backgroundImage: NetworkImage(""),
    //             )
    //
    //            ],
    //          )
    //        ],
    //      )
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: uiScreen(),
    );
  }
}
