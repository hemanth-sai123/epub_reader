// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  Nalp nalp;

  ErrorModel({
    required this.nalp,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    nalp: Nalp.fromJson(json["nalp"]),
  );

  Map<String, dynamic> toJson() => {
    "nalp": nalp.toJson(),
  };
}

class Nalp {
  String apiVersion;
  Message message;
  String requestedLimit;
  String requestedPage;
  String totalResults;
  String resultsInPage;

  Nalp({
    required this.apiVersion,
    required this.message,
    required this.requestedLimit,
    required this.requestedPage,
    required this.totalResults,
    required this.resultsInPage,
  });

  factory Nalp.fromJson(Map<String, dynamic> json) => Nalp(
    apiVersion: json["api-version"],
    message: Message.fromJson(json["message"]),
    requestedLimit: json["requested-limit"],
    requestedPage: json["requested-page"],
    totalResults: json["total-results"],
    resultsInPage: json["results-in-page"],
  );

  Map<String, dynamic> toJson() => {
    "api-version": apiVersion,
    "message": message.toJson(),
    "requested-limit": requestedLimit,
    "requested-page": requestedPage,
    "total-results": totalResults,
    "results-in-page": resultsInPage,
  };
}

class Message {
  String string;

  Message({
    required this.string,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    string: json["string"],
  );

  Map<String, dynamic> toJson() => {
    "string": string,
  };
}
