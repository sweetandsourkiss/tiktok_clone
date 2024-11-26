import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/repos/messages_repo.dart';

class MessagesViewModel extends FamilyAsyncNotifier<void, String> {
  late final MessagesRepo _repo;
  late final String chatRoomId;
  @override
  FutureOr<void> build(String arg) {
    _repo = ref.read(messagesRepo);
    chatRoomId = arg;
  }

  Future<void> sendMessage(String uid, String text) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final message = MessageModel(
          text: text,
          userId: user!.uid,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
        _repo.sendMessage(uid, message);
      },
    );
  }
}

final messagesProvider =
    AsyncNotifierProviderFamily<MessagesViewModel, void, String>(
  () => MessagesViewModel(),
);

final chatProvider = StreamProvider.family
    .autoDispose<List<MessageModel>, String>((ref, chatRoomId) {
  final db = FirebaseFirestore.instance;
  return db
      .collection("chat_rooms")
      .doc(chatRoomId)
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                doc.data(),
              ),
            )
            .toList()
            .reversed
            .toList(),
      );
});
