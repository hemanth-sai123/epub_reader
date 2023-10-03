import 'package:epub_reader/modal/search_modal.dart' as search_book_language;

abstract class BookState{

}
//
 class BookInitialState extends BookState{}

class BookLoadingState extends BookState {
  final List<search_book_language.Result> oldbooks;
  final bool isFirstFetch;
  BookLoadingState(this.oldbooks, {this.isFirstFetch=false});
}
class BookLoadedState extends BookState{
  List<search_book_language.Result> books;
  BookLoadedState(this.books);
}


class BookErrorState extends BookState{
  final String error;
  BookErrorState(this.error);
}
