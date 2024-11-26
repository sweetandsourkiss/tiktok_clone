import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';

class ChatRoomRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> makeRoom(ChatRoomModel room) async {
    await _db.collection('chat_rooms').add(room.toJson());
  }

  Future<List<ChatRoomModel>> getChatList(String uid) async {
    final chats = await _db
        .collection('chat_rooms')
        .where(
          Filter.or(
            Filter(
              'personA',
              isEqualTo: uid,
            ),
            Filter(
              'personB',
              isEqualTo: uid,
            ),
          ),
        )
        .get();
    return chats.docs
        .map(
          (doc) => ChatRoomModel.fromJson(
            doc.data(),
          ),
        )
        .toList();
  }
}

final chatRoomRepo = Provider((ref) => ChatRoomRepo());
