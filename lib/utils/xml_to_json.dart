import 'package:xml2json/xml2json.dart';

class XmlToJsonUtil{
  static final myTransformer = Xml2Json();
  static String toJson(String body){
    myTransformer.parse(body);
    return myTransformer.toParker();

  }
}