import 'dart:developer';

import 'package:crush_app/src/datasource/models/chat/chat_conversation_model.dart';
import 'package:crush_app/src/datasource/models/user/user_chat.dart';
import 'package:crush_app/src/datasource/repositories/chat_repository.dart';
import 'package:crush_app/src/shared/locator.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  ChatRepository _chatRepository = locator<ChatRepository>();

  bool isLoading = false;
  String? errorMessage = "";
  List<ChatConversationModel> conversations = [];
  // List<ChatMessage> chatMessages = [];
  List<UserChat> usersChat = [];
  ChatConversationModel? currentConversation;
  fetchConversations({String? identifier}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _chatRepository.getConversations();
      isLoading = false;
      notifyListeners();
      response.when(
        success: (data) {
          conversations = data;
          errorMessage = null;
          if (identifier != null) getConversationByChanelName(identifier);
          notifyListeners();
        },
        error: (error) {
          errorMessage = error.errorMessage;
          isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      // Passe l'état en "error" en cas d'échec

      errorMessage = e?.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  getUsersList() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _chatRepository.getUsersList();
      isLoading = false;
      notifyListeners();
      response.when(
        success: (data) {
          usersChat = data;
          notifyListeners();
        },
        error: (error) {
          errorMessage = error.errorMessage;
          isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      // Passe l'état en "error" en cas d'échec

      errorMessage = e?.toString();
      log(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  ChatConversationModel? getConversationByChanelName(String identifier) {
    ChatConversationModel? data;
    for (var conversation in conversations) {
      if (conversation.channelName == identifier) {
        currentConversation = conversation;
        notifyListeners();
        return conversation;
      }
    }

    for (var conversation in conversations) {
      for (var participant in conversation.participants) {
        if (participant.id == identifier) {
          currentConversation = conversation;
          notifyListeners();
          return conversation;
        }
      }
    }

    return currentConversation;
  }

  // void addToMessage(ChatMessage msg) {
  //   // Vérifiez si chatMessages contient déjà un message avec le même msgId
  //   bool exists =
  //       chatMessages.any((existingMsg) => existingMsg.msgId == msg.msgId);

  //   // Si le message n'existe pas, l'ajouter
  //   if (!exists) {
  //     chatMessages.add(msg);
  //     notifyListeners();
  //   }
  // }

  // addAllToMessage(List<ChatMessage> msgs) {
  //   chatMessages = msgs;
  //   notifyListeners();
  // }
}
