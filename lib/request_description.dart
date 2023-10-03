import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestDescription extends StatefulWidget {
  const RequestDescription({Key? key}) : super(key: key);

  @override
  State<RequestDescription> createState() => _RequestDescriptionState();
}
bool isFileExits=false;
bool isLoading=false;
class _RequestDescriptionState extends State<RequestDescription> {

  var lightBlue1 =Color(int.parse("0xff0295eb"));
  var lightBlue2 =Color(int.parse("0xff03b3ed"));
  bool isLoading=false;
  Widget uiScreen() {
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
      child: SafeArea(
          child: isLoading?Center(child: CircularProgressIndicator(),):Container(
              margin: EdgeInsets.only(left: 25,top: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text("Title",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  Text("The Wheel of Time",style: TextStyle(color: Colors.white,fontSize: 18)),
                  SizedBox(height: 10,),
                  Text("Author",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  Text("Ankita Priyadarsini",style: TextStyle(color: Colors.white,fontSize: 18)),
                  SizedBox(height: 10,),
                  Text("Size",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  Text("435MB",style: TextStyle(color: Colors.white,fontSize: 18)),
                  SizedBox(height: 10,),
                  Text("Download Format",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  Text("Daisy Audio Only",style: TextStyle(color: Colors.white,fontSize: 18)),
                  SizedBox(height: 10,),

                  Text("Language",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  Text("Odia",style: TextStyle(color: Colors.white,fontSize: 18)),
                  SizedBox(height: 10,),

                  Text("Synopsis",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  Text("Developed for students and general readers looking for a concise guide to the methods and purposes of historical study this book seeks to explore the nature of historical evidence to show how history comes to be written and to offer a basis on which good history can be distinguished from bad.",style: TextStyle(color: Colors.white,fontSize: 18)),
                  SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       height: 40,
                  //       width: MediaQuery.of(context).size.width*0.70,
                  //       //padding: EdgeInsets.all(10),
                  //       margin: EdgeInsets.all(10),
                  //       //width: MediaQuery.of(context).size.width,
                  //
                  //       color: Color(int.parse("0xffFFFFFF")),
                  //       child: Center(child: Text("Search By Book Name",style: TextStyle(color: Colors.black))),
                  //     ),
                  //     Icon(Icons.mic,color: Colors.white,)
                  //
                  //   ],
                  // ),
                  // SizedBox(
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: shelf.length,
                  //       itemBuilder: (ctx, index) {
                  //         return Container(
                  //             margin: EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                  //             width: MediaQuery.of(context).size.width,
                  //             child: Text(shelf[index],style: TextStyle(color: Colors.white,fontSize: 25)));
                  //       }),
                  // ),
                ],
              )
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 20,right: 25),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Center(child:
            // //
            // // loading?LinearPercentIndicator(
            // // lineHeight: 20,
            // //   percent: (_receivedBytes/_totalBytes)*100,
            // //   barRadius: const Radius.circular(16),
            // //   progressColor: Colors.green[400],
            // //   backgroundColor: Colors.grey[300],
            // // ):
            // isLoading?Container():Text("This book is ready for ${isFileExits?"Play":"Download"}",style: TextStyle(color: Color(int.parse("0xffDEFAA90E")),fontSize: 18),)),
            //
            SizedBox(height:25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isFileExits?Container():Flexible(
                  child: InkWell(
                    onTap: () async{

                      setState(() {
                        isFileExits=true;
                      });


                    },
                    child: Container(
                      height: 40,
                      //width: MediaQuery.of(context).size.width*0.50,
                      //padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      //width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: isLoading?Center(child: CircularProgressIndicator(),):Center(child: Text("Request Download",style: TextStyle(color: Colors.black))),
                    ),
                  ),
                ),
                Flexible(child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                   // width: MediaQuery.of(context).size.width*0.20,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    //width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Center(child: Text("Back",style: TextStyle(color: Colors.black))),
                  ),
                ),)

              ],
            ),
          ],
        ),
      ),
      body: uiScreen(),
    );
  }
}
