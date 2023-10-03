import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryActivity extends StatefulWidget {
  const LibraryActivity({Key? key}) : super(key: key);

  @override
  State<LibraryActivity> createState() => _LibraryActivityState();
}
class Books{

  String url;
  Books(this.url);
}
class _LibraryActivityState extends State<LibraryActivity> {
  var lightBlue1 =Color(int.parse("0xff0295eb"));
  var lightBlue2 =Color(int.parse("0xff03b3ed"));

  navigate(){
    Navigator.of(context).pushNamed("/description");
  }

  List<Books> list =[
    Books("https://cdn.hackr.io/uploads/posts/attachments/16431216080SuUqgLuUG.png"),
  Books("https://static.kopykitab.com/image/cache/data/faculty-notes/504098-300x380.jpg"),
    Books( "https://snatchbooks.com/wp-content/uploads/2020/10/Computer-System-Architecture-300x360.jpg"),
    Books("https://m.media-amazon.com/images/I/91ctlaHQLyL._AC_UF1000,1000_QL80_.jpg"),
    Books("https://cdn.hackr.io/uploads/posts/attachments/16431217469xj1pvxhms.png"),
    Books( "https://m.media-amazon.com/images/I/71uYIOC2mNS._AC_UF1000,1000_QL80_.jpg"),
    Books( "https://qph.cf2.quoracdn.net/main-qimg-4d98cb84e44ddfb3160ed36e52d014e6-lq"),
  ];

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
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("Liabray",style: TextStyle(fontSize: 20,color: Colors.white),),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1.65/2 ,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20
                    ),
                    itemCount:list.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var value =list[index];
                      return InkWell(
                        onTap: (){
                          navigate();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(

                              //width: MediaQuery.of(context).size.width*0.25,
                              // margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(value.url)
                                ),
                              ),
                              height: 200,
                            ),
                          ],
                        ),
                      );
                    }),
              )
            )

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: uiScreen(),
    );
  }
}
