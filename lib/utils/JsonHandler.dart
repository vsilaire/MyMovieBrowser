import 'package:http/http.dart' as http;
import 'dart:convert';


class JsonHandler {

  String _url;
  List data;

  JsonHandler();

  Future<String> getJsonData(String url) async{
  var response = await http.get(
  Uri.encodeFull(url),
  headers: {"Accept": "application/json"}
  );

  print(response.body);

  var convertDataToJson = json.decode(response.body);
  data = convertDataToJson['results'];


  return "Success";
  }
}


