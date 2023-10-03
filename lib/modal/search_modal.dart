// To parse this JSON data, do
//
//     final searchBookTitleModel = searchBookTitleModelFromJson(jsonString);

import 'dart:convert';

SearchBookTitleModel searchBookTitleModelFromJson(String str) => SearchBookTitleModel.fromJson(json.decode(str));

String searchBookTitleModelToJson(SearchBookTitleModel data) => json.encode(data.toJson());

class SearchBookTitleModel {
  SearchBookTitleModel({
    required this.nalp,
  });

  Nalp nalp;

  factory SearchBookTitleModel.fromJson(Map<String, dynamic> json) => SearchBookTitleModel(
    nalp: Nalp.fromJson(json["nalp"]),
  );

  Map<String, dynamic> toJson() => {
    "nalp": nalp.toJson(),
  };
}

class Nalp {
  Nalp({
    required this.apiVersion,
    required this.requestedLimit,
    required this.requestedPage,
    required this.totalResults,
    required this.resultsInPage,
    required this.books,
  });

  String apiVersion;
  String requestedLimit;
  String requestedPage;
  String totalResults;
  String resultsInPage;
  Books books;

  factory Nalp.fromJson(Map<String, dynamic> json) => Nalp(
    apiVersion: json["api-version"],
    requestedLimit: json["requested-limit"],
    requestedPage: json["requested-page"],
    totalResults: json["total-results"],
    resultsInPage: json["results-in-page"],
    books: Books.fromJson(json["books"]),
  );

  Map<String, dynamic> toJson() => {
    "api-version": apiVersion,
    "requested-limit": requestedLimit,
    "requested-page": requestedPage,
    "total-results": totalResults,
    "results-in-page": resultsInPage,
    "books": books.toJson(),
  };
}

class Books {
  Books({
    required this.list,
  });

  ListClass list;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
    list: ListClass.fromJson(json["list"]),
  );

  Map<String, dynamic> toJson() => {
    "list": list.toJson(),
  };
}

class ListClass {
  ListClass({
    required this.result,
  });

  List<Result> result;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.author,
    required this.briefSynopsis,
    required this.downloadFormat,
    required this.dtbookSize,
    required this.freelyAvailable,
    required this.id,
    required this.isbn13,
    required this.language,
    required this.publisher,
    required this.title,
    required this.data_url,
    required this.locator,
  });

  String author;
  String briefSynopsis;
  String downloadFormat;
  String dtbookSize;
  dynamic freelyAvailable;
  dynamic id;
  dynamic isbn13;
  dynamic language;
  String publisher;
  String title;
  String data_url;
  String locator;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    author: json["author"],
    briefSynopsis: json["brief-synopsis"]??json["brief_synopsis"]??"",
    downloadFormat: json["download-format"]??json["download_format"]??"",
    dtbookSize: json["dtbook-size"]??json["dtbook_size"]??"",
    freelyAvailable: json["freely-available"]??json["freely_available"]??"",
    id: json["id"]??"",
    isbn13: json["isbn13"]??"",
    language: json["language"]??"",
    publisher: json["publisher"]??"",
    title: json["title"]??"",
    data_url: json["data_url"]??"",
    locator: json["locator"]??"",
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "brief-synopsis": briefSynopsis,
    "download-format": downloadFormat,
    "dtbook-size": dtbookSize,
    "freely-available": freelyAvailable,
    "id": id,
    "isbn13": isbn13,
    "language": language,
    "publisher": publisher,
    "title": title,
    "data_url": data_url,
    "locator": locator,
  };
}

enum DownloadFormat { DAISY_AUDIO_ONLY, DAISY_TEXT_ONLY, EPUB_TEXT_ONLY }

final downloadFormatValues = EnumValues({
  "DAISY Audio Only": DownloadFormat.DAISY_AUDIO_ONLY,
  "DAISY Text Only": DownloadFormat.DAISY_TEXT_ONLY,
  "EPUB Text Only": DownloadFormat.EPUB_TEXT_ONLY
});

enum Language { HINDI, ENGLISH, FRENCH }

final languageValues = EnumValues({
  "English": Language.ENGLISH,
  "French": Language.FRENCH,
  "Hindi": Language.HINDI
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
