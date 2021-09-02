import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor extends InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('****************************************');
    print('Request for ${data.url}');
    print('****************************************');
    print('headers: ${data.headers}');
    print('method: ${data.method}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('****************************************');
    print('Response for ${data.url}');
    print('****************************************');
    print('status code: ${data.statusCode}');
    print('body: ${data.body}');
    return data;
  }
}
