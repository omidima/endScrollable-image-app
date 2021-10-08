import 'package:http/http.dart' as http;

class NetworkRequests {
  Future<http.Response> getImageList(int limit,int offset) async{
    return http.get(Uri.parse("https://picsum.photos/v2/list?page=${offset}&limit=${limit}"));
  }
}