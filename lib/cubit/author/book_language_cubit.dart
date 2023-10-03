
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:epub_reader/modal/search_modal.dart' as book_author_model;
import '../../repository/book_author_repository.dart';
import 'book_author_state.dart';


class BookLanguageCubit extends Cubit<BookState>{
  BookLanguageCubit(): super(BookInitialState()){
    // _fetchPost();
  }
  int currentAuthorTitlePage = 1;
  int currentLanguagePage = 1;
  //int currentPage = 1;
  List<book_author_model.Result> orgBooks=[];
  BookAuthorRepository _bookAuthorRepository =BookAuthorRepository();


  fetchLanguage(String newValue) async{
    // try{
    //   if (state is BookLoadingState) return;
    //
    //   final currentState = state;
    //
    //   var oldMovies = < book_author_model.Result>[];
    //   if (currentState is BookLoadedState) {
    //     oldMovies =currentLanguagePage == 1?[]:currentState.books;
    //   }
    //
    //   emit(BookLoadingState(oldMovies, isFirstFetch: currentLanguagePage == 1));
    //
    //   _bookAuthorRepository.fetchAuthorOrTitle(newValue,currentLanguagePage).then((topRatedMovies) {
    //     currentLanguagePage++;
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


}