import 'package:epub_reader/dash_board_activity.dart';
import 'package:epub_reader/description_activity.dart';
import 'package:epub_reader/login_activity.dart';
import 'package:epub_reader/request_description.dart';
import 'package:epub_reader/search_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'audio/audio_play.dart';
import 'audio/notifier/progress_manager.dart';
import 'cubit/author/book_author_cubit.dart';
import 'library_activity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<BookCubit>(
          create: (context) => BookCubit(),
        ),


      ],
      child: MaterialApp(
          routes: {
            "/home_page":(ctx)=>HomePage(),
            "/description":(ctx)=>DescriptionActivity(),
            "/request_description":(ctx)=>RequestDescription()
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          //home: const LoginActivity(),
         // home: const DashBoardActivity(),
          home: const HomePage(),
        ),
      // home: AudioEpubPlayer()),
      //home: AudioMyDataPlayer()),
    );
    // return MaterialApp(
    //   routes: {
    //     "/home_page":(ctx)=>HomePage(),
    //     "/description":(ctx)=>DescriptionActivity(),
    //     "/request_description":(ctx)=>RequestDescription()
    //   },
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   //home: const LoginActivity(),
    //  // home: const DashBoardActivity(),
    //   home: const HomePage(),
    // );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  static const List<Widget> _pages = <Widget>[
    DashBoardActivity(),
    SearchActivity(),
    LibraryActivity(),

  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  var lightBlue1 =Color(int.parse("0xff0295eb"));
  var lightBlue2 =Color(int.parse("0xff03b3ed"));
    var lightBlack =Color(int.parse("0xff35364a"));
  var backGroundColor =Color(int.parse("0xff1e223d"));
  var unselectedColors =Color(int.parse("0xff656673"));
  late final PageManager _pageManager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageManager = PageManager("bookName");
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.



    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        //height: 70,
        color: Colors.black.withOpacity(0.4),
        width: double.infinity,
        child: AudioControlButtons(),
      ),
      //  backgroundColor: Colors.transparent,
    extendBodyBehindAppBar: true,
    extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor:  Colors.black.withOpacity(0.4),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.lightBlue),
        unselectedItemColor: Colors.white,
        items:  [
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
           // icon: Icon(Icons.home),
            icon:Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.book),
            label: 'book',
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ));
  }
}
