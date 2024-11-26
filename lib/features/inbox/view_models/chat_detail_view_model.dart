import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_room_repo.dart';

class ChatDetailViewModel extends FamilyAsyncNotifier<ChatRoomModel, String> {
  late final ChatRoomRepo _chatRoomRepo;
  @override
  FutureOr<ChatRoomModel> build(String arg) async {
    _chatRoomRepo = ref.read(chatRoomRepo);
    return await _chatRoomRepo.getChatDetail(arg);
  }
}

final chatDetailProvider =
    AsyncNotifierProviderFamily<ChatDetailViewModel, ChatRoomModel, String>(
        () => ChatDetailViewModel());
