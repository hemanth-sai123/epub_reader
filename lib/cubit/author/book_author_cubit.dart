
import 'package:epub_reader/modal/search_modal.dart' as book_author_model;

import 'package:flutter_bloc/flutter_bloc.dart';


import '../../repository/book_author_repository.dart';
import '../../sqlfilte/db_helper.dart';
import '../../sqlfilte/db_services.dart';
import 'book_author_state.dart';


class BookCubit extends Cubit<BookState>{
  BookCubit(): super(BookInitialState()){
   // _fetchPost();
  }
  int currentPage = 1;
  List<book_author_model.Result> orgBooks = [];
 // int currentLanguagePage = 1;
  //int currentPage = 1;
  //List<book_author_model.Result> orgBooks=[];
  BookAuthorRepository _bookAuthorRepository =BookAuthorRepository();



  filterMyBooks(String type){
    List<book_author_model.Result> filterBooks = [];
    if(type =="audio"){
      print("sjjkjskjks audio "+orgBooks[0].downloadFormat.toString());
      filterBooks =orgBooks.where((element) => element.downloadFormat=="DAISY Audio Only").toList();
    //  emit(BookLoadedState(data));
    }else if(type=="text"){
      print("sjjkjskjks text "+orgBooks.length.toString());
      filterBooks =orgBooks.where((element) => element.downloadFormat=="DAISY Text Only").toList();
    }else if(type=="all"){
      print("sjjkjskjks all "+orgBooks.length.toString());
      filterBooks=orgBooks;
    }
    if(filterBooks.isEmpty){
      emit(BookErrorState("No Data Exists"));
    }else{
      emit(BookLoadedState(filterBooks));   
    }


    // if (state is BookLoadingState) return;
    //
    // final currentState = state;
    //
    // //var oldMovies = < book_author_model.Result>[];
    // if (currentState is BookLoadedState) {
    //   orgBooks =currentState.books;
    //   List<book_author_model.Result> list = currentState.books.where((element) => element.downloadFormat=="DAISY Audio Only").toList();
    //   emit(BookLoadedState(list));
    // }
  }

  void getAllMyBooks() {


    getResults();

  }
  var database =DBServices();
  late DatabaseHelper databaseHelper;

  void update(Map<String, dynamic> row) async{
    databaseHelper =await database.initState();

    await databaseHelper.update(row);
    //getResults();

  }

  void getResults() async{
    // var results =Provider.of<SearchBooksViewModel>(context, listen: false).searchBookModelData?.nalp.books.list.result;
    databaseHelper =await database.initState();

    var list =await databaseHelper.queryAllRows();
    List<book_author_model.Result> myBooks = [];
    for(int i=0;i<list.length;i++){
      myBooks.add(book_author_model.Result.fromJson(list[i]));
    }

    print("resjlsllsnwereeeeeeeeeeeeeeeuuue  "+list.toString());
    myBooks =myBooks.where((element) => element.data_url!=null).toList();
    if(myBooks.isEmpty){

      emit(BookErrorState("data not exit"));
    }else{
      emit(BookLoadedState(myBooks));
    }


  }




  paggination(Future<Object> Function(String author, int currentPage) fetch, String newValue){
    try{
      if (state is BookLoadingState) return;

      final currentState = state;

      var oldMovies = < book_author_model.Result>[];
      if (currentState is BookLoadedState) {
        oldMovies = currentPage==1?[]:currentState.books;
      }

      // if(currentPage==1)
      //   orgBooks =[];

      emit(BookLoadingState(oldMovies, isFirstFetch: currentPage == 1));

      fetch(newValue,currentPage).then((topRatedMovies) {
        try{

          var data =topRatedMovies as List<book_author_model.Result>;
          final movies = (state as BookLoadingState).oldbooks;
          movies.addAll(data);
          currentPage++;
          orgBooks=movies;
          emit(BookLoadedState(movies));


          //emit(BookLoadedState(data));
          print("jdskjkjkdjjsjkjd1234 "+data.toString());
        }catch(e){
          if(orgBooks.isEmpty){
            emit(BookErrorState(topRatedMovies as String));
          }else{
            if(currentPage==1){
              emit(BookErrorState(topRatedMovies as String));
            }else{
              emit(BookLoadedState(orgBooks));
            }

          }
        }

      });
      // emit(BookLoadingState());
      // List<book_author_model.Result> books =await _bookAuthorRepository.fetchAuthor(newValue,currentPage);
      // emit(BookLoadedState(books));
    }catch(e){

      print("kskldkldslkkldsklsldk "+e.toString());
      emit(BookErrorState(e.toString()));
    }
  }

  paggination1(Future<Object> Function(String nofTimeDelivered, String start, String end, int currentPage) getSearchPopularBooks, String count, String start, String end){
    try{
      if (state is BookLoadingState) return;

      final currentState = state;

      var oldMovies = < book_author_model.Result>[];
      if (currentState is BookLoadedState) {
        oldMovies = currentPage==1?[]:currentState.books;
      }

      emit(BookLoadingState(oldMovies, isFirstFetch: currentPage == 1));

      getSearchPopularBooks(count,start,end,currentPage).then((topRatedMovies) {
        try{
          currentPage++;
          var data =topRatedMovies as List<book_author_model.Result>;
          final movies = (state as BookLoadingState).oldbooks;
          movies.addAll(data);

          orgBooks =movies;
          emit(BookLoadedState(movies));


          //emit(BookLoadedState(data));
          print("jdskjkjkdjjsjkjd1234 "+data.toString());
        }catch(e){
          if(orgBooks.isEmpty){
            emit(BookErrorState(topRatedMovies as String));
          }else{
            emit(BookLoadedState(orgBooks));
          }
          print("jdskjkjkdjjsjkjd567 "+e.toString());

        }

      });
      // emit(BookLoadingState());
      // List<book_author_model.Result> books =await _bookAuthorRepository.fetchAuthor(newValue,currentPage);
      // emit(BookLoadedState(books));
    }catch(e){

      print("kskldkldslkkldsklsldk "+e.toString());
      emit(BookErrorState(e.toString()));
    }
  }
  initialState(){
   // if (state is BookLoadingState) return;

    final currentState = state;
    if (currentState is BookLoadedState) {
      currentState.books=[];
    }

  }

  fetchTile(String newValue) async{
    await paggination(_bookAuthorRepository.fetchBookTitle, newValue);
  }

  fetchAuthor(String newValue) async{
    await paggination(_bookAuthorRepository.fetchBookAuthor, newValue);
  }

  fetchLanguage(String newValue) async{
    await paggination(_bookAuthorRepository.getSearchBooksByLanguage, newValue);
  }


  fetchCategories(String newValue) async{
    await paggination(_bookAuthorRepository.getSearchBooksByCategory, newValue);
  }
  fetchPopularBooks(String count,String start,String end) async{
    await paggination1(_bookAuthorRepository.getSearchPopularBooks, count,start,end);
  }

  fetchLatestBooks() async{

    emit(BookInitialState());
    _bookAuthorRepository.fetchLatestBooks(currentPage).then((value) {
      try{
        var data =value as List<book_author_model.Result>;
        emit(BookLoadedState(data));
        orgBooks=data;
        print("jdskjkjkdjjsjkjd1234 "+data.toString());
      }catch(e){
        print("jdskjkjkdjjsjkjd567 "+e.toString());
        emit(BookErrorState(value as String));
      }
    });
    // try{
    //   if (state is BookLoadingState) return;
    //
    //   final currentState = state;
    //
    //   var oldMovies = < book_author_model.Result>[];
    //   if (currentState is BookLoadedState) {
    //     oldMovies = currentState.books;
    //   }
    //
    //   emit(BookLoadingState(oldMovies, isFirstFetch: currentPage == 1));
    //
    //   _bookAuthorRepository.fetchLatestBooks(currentPage).then((topRatedMovies) {
    //     currentPage++;
    //
    //     final movies = (state as BookLoadingState).oldbooks;
    //     movies.addAll(topRatedMovies);
    //
    //     emit(BookLoadedState(movies));
    //   });
    //   // emit(BookLoadingState());
    //   // List<book_author_model.Result> books =await _bookAuthorRepository.fetchAuthor(newValue,currentPage);
    //   // emit(BookLoadedState(books));
    // }catch(e){
    //
    //   print("kskldkldslkkldsklsldk "+e.toString());
    //   emit(BookErrorState(e.toString()));
    // }
  }



  //
  // delete() {
  //   currentPage =1;
  //   emit(BookLoadingState([]));
  // }

}