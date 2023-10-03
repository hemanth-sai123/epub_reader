import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
class ApiServices {
  // BuildContext context;
  // ApiServices(this.context);
  String username = 'vishnuavula7@gmail.com';
  String password = 'gyanrathan123\$';

  Dio _dio =Dio();

  ApiServices(){
     _dio.options.baseUrl ="https://library.daisyindia.org/NALP/rest/NALPAPIService";
  }

  Dio get sendRequest =>_dio;

  final _base_url_1 =
      "https://boomarango-dot-folkloric-union-281507.el.r.appspot.com/v1";
  final _base_url_2 =
      "https://boomservices-dot-folkloric-union-281507.el.r.appspot.com/v1";

  Future<http.Response> getSearchBooks(String bookId) async {
    //final url="https://db-apis-dot-folkloric-union-281507.el.r.appspot.com/stores/$id/employees";

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final url =
        "https://library.daisyindia.org/NALP/rest/NALPAPIService/getNALPData/id/${bookId}/page/1/limit/1/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802";
    //final url="http://42934c751b96.ngrok.io/stores/$id/employees";
    final requestHeaders = {
      "book_Id":bookId,
      "page":"1",
      "limit":"1",
      "authorization": basicAuth,
      "API_key":"0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
    };


    final res = await http.get(Uri.parse(url),
        headers: requestHeaders);

    return res;
  }

  Future<http.Response> getSearchBooksByTitle(String newValue) async {
    //final url="https://db-apis-dot-folkloric-union-281507.el.r.appspot.com/stores/$id/employees";

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final url =
        "https://library.daisyindia.org/NALP/rest/NALPAPIService/getNALPData/title/${newValue}/page/1/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802";
    //final url="http://42934c751b96.ngrok.io/stores/$id/employees";
    final requestHeaders = {
      "book_Id":"28",
      "page":"1",
      "limit":"1",
      "authorization": basicAuth,
      "API_key":"0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
    };


    final res = await http.get(Uri.parse(url),
        headers: requestHeaders);

    return res;
  }


  Future<http.Response> getSearchBooksByLanguage(String language) async {
    //final url="https://db-apis-dot-folkloric-union-281507.el.r.appspot.com/stores/$id/employees";

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final url =
        "https://library.daisyindia.org/NALP/rest/NALPAPIService/getNALPData/language/${language}/page/1/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802";
    //final url="http://42934c751b96.ngrok.io/stores/$id/employees";
    final requestHeaders = {
      // "book_Id":"28",
      // "page":"1",
      // "limit":"1",
      "authorization": basicAuth,
     // "API_key":"0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
    };


    final res = await http.get(Uri.parse(url),
        headers: requestHeaders);

    return res;
  }
  //
  Future<http.Response> getSearchBooksByPopular() async {
    //final url="https://db-apis-dot-folkloric-union-281507.el.r.appspot.com/stores/$id/employees";
  //  https://library.daisyindia.org/NALP/rest/NALPAPIService/downloadFile/Lights Out-22.zip?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final url =
        "https://library.daisyindia.org/NALP/rest/NALPAPIService/getNALPData/latest/page/1/limit/10/format/xml?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802";
    //final url="http://42934c751b96.ngrok.io/stores/$id/employees";
    final requestHeaders = {
      // "book_Id":"28",
      // "page":"1",
      // "limit":"1",
      "authorization": basicAuth,
      // "API_key":"0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
    };


    final res = await http.get(Uri.parse(url),
        headers: requestHeaders);

    return res;
  }

  Future<http.Response> getSearchDownload() async {
    //final url="https://db-apis-dot-folkloric-union-281507.el.r.appspot.com/stores/$id/employees";

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final url =
        "https://library.daisyindia.org/NALP/rest/NALPAPIService/downloadFile/Lights Out-22.zip?API_key=0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802";
    //final url="http://42934c751b96.ngrok.io/stores/$id/employees";
    final requestHeaders = {
      // "book_Id":"28",
      // "page":"1",
      // "limit":"1",
      "authorization": basicAuth,
      // "API_key":"0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
    };


    final res = await http.get(Uri.parse(url),
        headers: requestHeaders);

    return res;
  }
  //


  Future<http.Response> raiseBookDownloadRequest(String newValue) async{
    //final url="https://db-apis-dot-folkloric-union-281507.el.r.appspot.com/stores/$id/employees";



    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final url = "https://library.daisyindia.org/NALP/rest/NALPAPIService/raiseBookDownloadRequest";
    //final url="http://42934c751b96.ngrok.io/stores/$id/employees";
    final requestHeaders = {
      "bookId":newValue,
      "formatId":"6",
      "authorization":basicAuth,
      "API_key":"0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
    };

late http.Response res;
    try{
      res = await http.post(Uri.parse(url),
          headers: requestHeaders);
      print("raise error kldskls1 "+res.statusCode.toString()+"  ${newValue}  "+"                    "+res.body.toString());
    }
    catch(e){
      print("raise error kldskl2 "+e.toString());
    }



    return res;
  }

  Future<http.Response> fetchBooksDownloadRequest() async{
    //final url="https://db-apis-dot-folkloric-union-281507.el.r.appspot.com/stores/$id/employees";

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final url =
        "https://library.daisyindia.org/NALP/rest/NALPAPIService/fetchUserDownloadRequests";
    //final url="http://42934c751b96.ngrok.io/stores/$id/employees";
    final requestHeaders = {
      "page":"1",
      "format":"xml",
      "limit":"15",
      "authorization": basicAuth,
      "API_key":"0E98548C2015EFA7D1FD4BA1C8F7A314ABB0EFE2EC19D6CC1646223337802",
    };


    final res = await http.post(Uri.parse(url),
        headers: requestHeaders);

    print(res.body.toString());
    return res;
  }


  // Future<http.Response> getUpcomingList(String customerUserKey, int currentPage,
  //     BuildContext context) async {
  //   //final url="https://db-apis-dot-folkloric-union-281507.el.r.appspot.com/stores/$id/employees";
  //   final url =
  //       "$_base_url_1/upcoming_bookings/user/${customerUserKey}/new?page=${currentPage}";
  //   //final url="http://42934c751b96.ngrok.io/stores/$id/employees";
  //   final requestHeaders = await getHeaders();
  //
  //   final res = await http.get(Uri.parse(url), headers: requestHeaders);
  //   return res;
  // }
}