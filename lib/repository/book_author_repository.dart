import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:epub_reader/modal/search_modal.dart' as search_book_author;
import 'package:epub_reader/modal/error_model.dart' as error_model;

import '../ApiServices.dart';
import '../utils/xml_to_json.dart';
class BookAuthorRepository{
  ApiServices api =ApiServices();
  Future<Object> fetchBookTitle(String title, int currentPage) async{
    var response;
    try{
      String username = '38029';
      String password = 'Welcome@789';
      print("kldsklkldsklkldskldkls "+currentPage.toString());
      var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));
      //response =await api.sendRequest.get("/getNALPData/authortitle/$author/page/$currentPage/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",

      response =await api.sendRequest.get("/getNALPData/title/${title}/page/${currentPage}/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
        options: Options(headers: <String, String>{'authorization': auth}),);
      var ss=XmlToJsonUtil.toJson(response.data);
      print("kldlkddkdddkdkdk "+ss.toString());
      return search_book_author.searchBookTitleModelFromJson(ss).nalp.books.list.result;
    }catch(e){
      print("lkdsklklskllksd " +e.toString());
       var ss=XmlToJsonUtil.toJson(response.data);
       return error_model.errorModelFromJson(ss).nalp.message.string;
    }

  }

  Future<Object> fetchBookAuthor(String author, int currentPage) async{
    var response;
    try{
      String username = 'vishnuavula7@gmail.com';
      String password = 'gyanrathan123\$';
      print("kldsklkldsklkldskldkls "+currentPage.toString());
      var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));
      //response =await api.sendRequest.get("/getNALPData/authortitle/$author/page/$currentPage/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
      response =await api.sendRequest.get("/getNALPData/author/${author}/page/${currentPage}/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
        options: Options(headers: <String, String>{'authorization': auth}),);
      var ss=XmlToJsonUtil.toJson(response.data);
      print("kldlkddkdddkdkdk "+ss.toString());
      return search_book_author.searchBookTitleModelFromJson(ss).nalp.books.list.result;
    }catch(e){
      var ss=XmlToJsonUtil.toJson(response.data);
      return error_model.errorModelFromJson(ss).nalp.message.string;
    }

  }

  Future<Object> fetchLatestBooks(int currentPage) async{
    var response;
    try{
      String username = 'vishnuavula7@gmail.com';
      String password = 'gyanrathan123\$';
      var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));
      response =await api.sendRequest.get("/getNALPData/latest/page/$currentPage/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
        options: Options(headers: <String, String>{'authorization': auth}),);
      var ss=XmlToJsonUtil.toJson(response.data);
      print("kldlkddkdddkdkdk123 "+ss.toString());
      return search_book_author.searchBookTitleModelFromJson(ss).nalp.books.list.result;
    }catch(e){
      var ss=XmlToJsonUtil.toJson(response.data);
      return error_model.errorModelFromJson(ss).nalp.message.string;
    }

  }

  Future<Object> getSearchBooksByCategory(String newValue, int currentPage) async {
    var response;
    try{
      String username = 'vishnuavula7@gmail.com';
      String password = 'gyanrathan123\$';
      var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));

      print("newvaluejcjkdsjk "+newValue.toString()+"   "+currentPage.toString());
      response =await api.sendRequest.get("/getNALPData/category/${newValue}/page/${currentPage}/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
        options: Options(headers: <String, String>{'authorization': auth}),);

      var ss=XmlToJsonUtil.toJson(response.data);
      print("kldlkddkdddkdkdk "+ss.toString());
      return search_book_author.searchBookTitleModelFromJson(ss).nalp.books.list.result;
    }catch(e){
      var ss=XmlToJsonUtil.toJson(response.data);
      return error_model.errorModelFromJson(ss).nalp.message.string;
      //var ss=XmlToJsonUtil.toJson(response.data);
      throw e;
    }

  }

  Future<Object> getSearchPopularBooks(String nofTimeDelivered,String start,String end, int currentPage) async {
    var response;
    try{
      String username = 'vishnuavula7@gmail.com';
      String password = 'gyanrathan123\$';
      var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));

      //print("newvaluejcjkdsjk "+newValue.toString()+"   "+currentPage.toString());
      response =await api.sendRequest.get("/getNALPData/popularbooks/noOfTimesDelivered/${nofTimeDelivered}/startDate/2016-01-01/endDate/2016-08-08/page/${currentPage}/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
        options: Options(headers: <String, String>{'authorization': auth}),);

      var ss=XmlToJsonUtil.toJson(response.data);
      print("kldlkddkdddkdkdk "+ss.toString());
      return search_book_author.searchBookTitleModelFromJson(ss).nalp.books.list.result;
    }catch(e){
      var ss=XmlToJsonUtil.toJson(response.data);
      return error_model.errorModelFromJson(ss).nalp.message.string;
      //var ss=XmlToJsonUtil.toJson(response.data);
      throw e;
    }

  }

  Future<Object> getSearchBooksByLanguage(String language, int currentPage) async {
    var response;
    try{
      String username = 'vishnuavula7@gmail.com';
      String password = 'gyanrathan123\$';
      var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));
      response =await api.sendRequest.get("/getNALPData/language/${language}/page/${currentPage}/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
        options: Options(headers: <String, String>{'authorization': auth}),);
      var ss=XmlToJsonUtil.toJson(response.data);
      print("kldlkddkdddkdkdk "+ss.toString());
      return search_book_author.searchBookTitleModelFromJson(ss).nalp.books.list.result;
    }catch(e){
      var ss=XmlToJsonUtil.toJson(response.data);
      return error_model.errorModelFromJson(ss).nalp.message.string;
      //var ss=XmlToJsonUtil.toJson(response.data);
      throw e;
    }

  }
}