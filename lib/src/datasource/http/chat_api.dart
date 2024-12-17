import 'package:dio/dio.dart';

class ChatApi {
  final Dio dio;

  ChatApi({required this.dio});

  // Créer un compte
  Future<Response> getConversations() async {
    return dio.get('/chat/conversations');

    // return response;
  }

  Future<Response> getConversationToken(String destinatorId) async {
    var body = {"destinatorId": destinatorId};
    return dio.post('/chat/generate-chat-token', data: body);

    // return response;
  }

  Future<Response> getUsersList() async {
    return dio.get('/user/list');
  }
}
