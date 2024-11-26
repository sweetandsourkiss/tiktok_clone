import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';

class ChatRoomRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> makeRoom(ChatRoomModel room) async {
    await _db.collection('chat_rooms').doc(room.uid).set(room.toJson());
  }

  Future<ChatRoomModel> getChatDetail(String uid) async {
    final detail = await _db.collection("chat_rooms").doc(uid).get();
    return ChatRoomModel.fromJson(detail.data()!);
  }

  Future<List<ChatRoomModel>> getChatList(String uid) async {
    final chats = await _db
        .collection('chat_rooms')
        .where(
          Filter.or(
            Filter(
              'personAuid',
              isEqualTo: uid,
            ),
            Filter(
              'personBuid',
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
