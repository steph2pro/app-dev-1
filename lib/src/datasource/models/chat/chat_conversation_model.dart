import 'package:crush_app/src/datasource/models/chat/participant_model.dart';

class ChatConversationModel {
  final String id;
  final String channelName;
  final String? label;
  final List<Participant> participants;

  ChatConversationModel({
    required this.id,
    required this.channelName,
    this.label,
    required this.participants,
  });

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    return ChatConversationModel(
      id: json['id'],
      channelName: json['channelName'],
      label: json['label'],
      participants: (json['participants'] as List)
          .map((participant) => Participant.fromJson(participant))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'channelName': channelName,
      'label': label,
      'participants':
          participants.map((participant) => participant.toJson()).toList(),
    };
  }
}
