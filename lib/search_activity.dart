import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/author/book_author_cubit.dart';
import 'cubit/author/book_author_state.dart';
import 'modal/search_modal.dart' as search_book_title;
class SearchActivity extends StatefulWidget {
  const SearchActivity({Key? key}) : super(key: key);

  @override
  State<SearchActivity> createState() => _SearchActivityState();
}

class _SearchActivityState extends State<SearchActivity> {

  late TextEditingController _editingController;
  Future<bool> initilization() async{
    BlocProvider.of<BookCubit>(context).currentPage=1;
    BlocProvider.of<BookCubit>(context).emit(BookInitialState());
    return true;
  }

  apiCallMethod(){
    BlocProvider.of<BookCubit>(context).fetchTile(_editingController.text.toString());
  }
  @override
  void initState() {
    super.initState();
    initilization();
    _editingController = TextEditingController(text: "a");
    apiCallMethod();
    //_listofFiles();

  }

  @override
  void dispose() {
    BlocProvider.of<BookCubit>(context).emit(BookInitialState());
    _editingController.dispose();
    super.dispose();
  }
  final scrollController = ScrollController();

  void setupScrollController(context,String newValue) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          //BlocProvider.of<BookCubit>(context).fetchAuthor(newValue);
          apiCallMethod();
        }
      }
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }


  Widget _builder(){
    return Expanded(
      child: BlocBuilder<BookCubit,BookState>(
          builder:(context,state) {

            if (state is BookInitialState) {
              print("kldllksdkldklsdklinitialrun ");
              BlocProvider.of<BookCubit>(context).currentPage=1;
              //BlocProvider.of<BookCubit>(context).initialState();
              return _loadingIndicator();
            }

            if (state is BookErrorState) {
              print("djllkdsskldsklkldkldkslkldskldklerror "+state.error.toString());
              return Center(
                child: Text(state.error.toString(),style: TextStyle(color: Color(int.parse("0xffDEFAA90E"))),),
              );
            }


            if (state is BookLoadingState && state.isFirstFetch) {
              return _loadingIndicator();
            }

            List<search_book_title.Result> movies = [];
            bool isLoading = false;

            if (state is BookLoadingState) {
              movies = state.oldbooks;
              isLoading = true;
            } else if (state is BookLoadedState) {
              movies = state.books;
            }

            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index1) {
                if (index1 < movies.length)
                  return InkWell(
                    onTap: () {
                      // if(index==0){
                      //   Navigator.of(context).pushNamed(
                      //       "/requestBookDescriptionActivity", arguments: {
                      //     "isAvailable":"Available for Download",
                      //     "bookName":movies[index1].title,
                      //     "bookUrl":movies[index1].data_url
                      //   });
                      // }else{
                      //   print("idsss "+movies[index1].id.toString());
                      //   Navigator.of(context).pushNamed(
                      //       "/bookDescriptionActivity", arguments: {
                      //     "url": movies[index1].title,
                      //     "bookName": movies[index1].title,
                      //     "bookId": movies[index1].id,
                      //
                      //   });
                      //   if (!isDownloads) {
                      //
                      //   } else {
                      //     // Navigator.of(context).pushNamed(
                      //     //     "/mainActivity", arguments: {
                      //     //   "bookName": searchedBooksTitle[index].title,
                      //     // });
                      //   }
                      // }


                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 10, top: 10, bottom: 10),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Text(movies[index1].title,
                            style: TextStyle(
                                color: Colors.white, fontSize: 18))),
                  );
                else {
                  Timer(Duration(milliseconds: 30), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });

                  return _loadingIndicator();
                }
              },

              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                  thickness: 0.1,
                );
              },
              itemCount: movies.length + (isLoading ? 1 : 0),
            );

          }
      ),
    );
  }
  var lightBlue1 =Color(int.parse("0xff0295eb"));
  var lightBlue2 =Color(int.parse("0xff03b3ed"));

  List<String> data =["The Wheel of Time",
    "A Dolls House by Henrik Ibsen",
    "The Lost Hero","Six Acres and a Third",
    "Bankim Omnibus 1",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",
    "The Wheel of Time",

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
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10,right: 10,top: 30),
            decoration: BoxDecoration(
              color: Colors.white,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(0.2))
            ),
            child: TextField(
              onChanged: (newValue){
                //setState(() {
                // if(newValue.isEmpty){
                //   editTextValue=text;
                // }else{
                //   editTextValue=newValue;
                //   // BlocProvider.of<BookCubit>(context).filterMyBooks("all");
                // }
                initilization().then((value) => apiCallMethod());


              },
              decoration: InputDecoration(
                  border: InputBorder.none
                  ,prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.keyboard_voice),
                  hintText: "Search"
              ),
            ),
          ),
         _builder()
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
