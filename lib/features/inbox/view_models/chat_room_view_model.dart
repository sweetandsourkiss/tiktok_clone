import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_room_repo.dart';

class ChatRoomViewModel extends AsyncNotifier<List<ChatRoomModel>> {
  late final ChatRoomRepo _chatRoomRepo;

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    final user = ref.read(authRepo).user;
    _chatRoomRepo = ref.read(chatRoomRepo);
    return await _chatRoomRepo.getChatList(user!.uid);
  }

  Future<void> makeRoom(String personBuid) async {
    final user = ref.read(authRepo).user;

    final room = ChatRoomModel(
      uid: "",
      personAuid: user!.uid,
      personAname: "",
      personBuid: personBuid,
      personBname: "",
      lastChattedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _chatRoomRepo.makeRoom(room);
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModel, List<ChatRoomModel>>(
  () => ChatRoomViewModel(),
);
