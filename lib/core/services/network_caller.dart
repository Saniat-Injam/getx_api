import 'package:http/http.dart' as http;

class NetworkCaller {
  Future<http.Response> getRequest(String endPoint) async {
    try {
      // final uri = Uri.parse(endPoint);
      // final response = await http.get(uri);

      final response = await http.get(Uri.parse(endPoint));

      return response;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }
}
