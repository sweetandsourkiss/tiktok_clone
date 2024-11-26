import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_room_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class ChatRoomViewModel extends AsyncNotifier<List<ChatRoomModel>> {
  late final ChatRoomRepo _chatRoomRepo;

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    final user = ref.read(authRepo).user;
    _chatRoomRepo = ref.read(chatRoomRepo);
    return await _chatRoomRepo.getChatList(user!.uid);
  }

  Future<String> makeRoom(String selectedUid, String selectedName) async {
    final personAprofile = ref.read(usersProvider);
    final url = "${personAprofile.value!.uid}--$selectedUid";
    final room = ChatRoomModel(
      uid: url,
      personAuid: personAprofile.value!.uid,
      personAname: personAprofile.value!.name,
      personBuid: selectedUid,
      personBname: selectedName,
      lastChat: "",
      lastChattedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _chatRoomRepo.makeRoom(room);
    return url;
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModel, List<ChatRoomModel>>(
  () => ChatRoomViewModel(),
);
