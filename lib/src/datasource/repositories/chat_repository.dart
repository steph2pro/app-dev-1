import 'package:crush_app/src/datasource/http/chat_api.dart';
import 'package:crush_app/src/datasource/http/dio_config.dart';
import 'package:crush_app/src/datasource/models/api_response/api_response.dart';
import 'package:crush_app/src/datasource/models/chat/chat_conversation_model.dart';
import 'package:crush_app/src/datasource/models/user/user_chat.dart';
import 'package:crush_app/src/datasource/repositories/base_repository.dart';
import 'package:crush_app/src/shared/locator.dart';

class ChatRepository extends BaseRepository {
  final ChatApi chatApi;

  ChatRepository({
    ChatApi? chatApi,
  }) : chatApi = chatApi ?? ChatApi(dio: locator<DioConfig>().dio);

  Future<ApiResponse<List<ChatConversationModel>, ApiError>>
      getConversations() async {
    return runApiCall(
      call: () async {
        final response = await chatApi.getConversations();
        var datas = (response.data as List).map((element) {
          return ChatConversationModel.fromJson(element);
        }).toList();

        return ApiResponse.success(datas);
      },
    );
  }

  Future<ApiResponse<String, ApiError>> getConversationToken(
      String destinatorId) async {
    return runApiCall(
      call: () async {
        final response = await chatApi.getConversationToken(destinatorId);
        return ApiResponse.success(response.data['token']);
      },
    );
  }

  Future<ApiResponse<List<UserChat>, ApiError>> getUsersList() async {
    return runApiCall(
      call: () async {
        final response = await chatApi.getUsersList();

        var datas = (response.data as List).map((element) {
          return UserChat.fromJson(element);
        }).toList();
        return ApiResponse.success(datas);
      },
    );
  }
}
