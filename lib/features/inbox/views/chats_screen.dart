import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/view_models/chat_room_view_model.dart';
import 'package:tiktok_clone/features/inbox/views/chat_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/inbox/views/widgets/user_list.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  static const String routeName = 'chats';
  static const String routeURL = '/chats';

  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  void _showUsers(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const UserList(),
    );
  }

  void _onChatTap(int index) {
    context.pushNamed(ChatDetailScreen.routeName, params: {
      "chatId": "$index",
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncChatRooms = ref.watch(chatRoomProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct Messages"),
        surfaceTintColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => _showUsers(context),
            icon: const FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      body: asyncChatRooms.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        data: (data) {
          return ListView.separated(
            separatorBuilder: (context, index) => Gaps.v32,
            padding: const EdgeInsets.all(
              Sizes.size16,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: () {},
                onTap: () => _onChatTap(index),
                leading: CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/tiktok-sask-project.firebasestorage.app/o/avatars%2F${data[index].personAuid}?alt=media&token=a8f4c6f3-580f-4cb2-a598-a16a21f63d5b",
                  ),
                  child: const Text("새콤"),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'hello',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${DateTime.fromMillisecondsSinceEpoch(data[index].lastChattedAt).toLocal()}",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Sizes.size12,
                      ),
                    ),
                  ],
                ),
                subtitle: const Text("Don't forget to make video"),
              );
            },
          );
        },
      ),
    );
  }
}
