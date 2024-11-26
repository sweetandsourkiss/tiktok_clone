import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/common/widgets/theme_config/theme_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/view_models/chat_room_view_model.dart';
import 'package:tiktok_clone/features/users/view_models/user_list_view_model.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList({super.key});

  @override
  UserListState createState() => UserListState();
}

class UserListState extends ConsumerState<UserList> {
  final ScrollController scrollController = ScrollController();

  void _onUserTap(BuildContext context, String uid) {
    ref.read(chatRoomProvider.notifier).makeRoom(uid);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final asyncUsers = ref.watch(userListProvider);

    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
          centerTitle: true,
        ),
        body: Scrollbar(
            controller: scrollController,
            child: asyncUsers.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              data: (data) => ListView.separated(
                controller: scrollController,
                separatorBuilder: (context, index) => Gaps.v32,
                padding: const EdgeInsets.all(
                  Sizes.size16,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _onUserTap(context, data[index].uid),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor:
                            darkModeConfig.value ? Colors.grey.shade800 : null,
                        foregroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/tiktok-sask-project.firebasestorage.app/o/avatars%2F${data[index].uid}?alt=media&token=a8f4c6f3-580f-4cb2-a598-a16a21f63d5b",
                        ),
                        child: Text(data[index].name),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Text(
                          data[index].name,
                          style: const TextStyle(
                            fontSize: Sizes.size20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
