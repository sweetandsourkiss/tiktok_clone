import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/view_models/chat_detail_view_model.dart';
import 'package:tiktok_clone/features/inbox/view_models/messages_view_model.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _editingController = TextEditingController();

  void _onSendPress() {
    final text = _editingController.text;
    if (text == "") {
      return;
    }
    ref.read(messagesProvider.notifier).sendMessage(widget.chatId, text);
    _editingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider).isLoading;
    final userId = ref.read(authRepo).user!.uid;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.grey.shade400,
        title: ref.watch(chatDetailProvider(widget.chatId)).when(
          loading: () {
            return const CircularProgressIndicator();
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          data: (data) {
            final isPersonA = userId == data.personAuid;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: Sizes.size8,
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: Sizes.size24,
                    foregroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/tiktok-sask-project.firebasestorage.app/o/avatars%2F${isPersonA ? data.personBuid : data.personAuid}?alt=media&token=a8f4c6f3-580f-4cb2-a598-a16a21f63d5b",
                    ),
                    child: Text(
                      isPersonA ? data.personBname : data.personAname,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(
                        Sizes.size3,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            Sizes.size96,
                          ),
                        ),
                      ),
                      child: Container(
                        width: Sizes.size12,
                        height: Sizes.size12,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              Sizes.size96,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                isPersonA ? data.personBname : data.personAname,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Active now",
                style: TextStyle(
                  fontSize: Sizes.size12,
                  color: Colors.grey.shade500,
                ),
              ),
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.flag,
                    size: Sizes.size20,
                    color: Colors.black,
                  ),
                  Gaps.h32,
                  FaIcon(
                    FontAwesomeIcons.ellipsis,
                    size: Sizes.size20,
                    color: Colors.black,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          ref.watch(chatProvider).when(
                data: (data) {
                  return ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom:
                          MediaQuery.of(context).padding.bottom + Sizes.size96,
                      left: Sizes.size14,
                      right: Sizes.size14,
                    ),
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine =
                          message.userId == ref.watch(authRepo).user!.uid;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                              Sizes.size14,
                            ),
                            decoration: BoxDecoration(
                              color: isMine
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(
                                    Sizes.size20,
                                  ),
                                  topRight: const Radius.circular(
                                    Sizes.size20,
                                  ),
                                  bottomLeft: Radius.circular(
                                    isMine ? Sizes.size20 : Sizes.size5,
                                  ),
                                  bottomRight: Radius.circular(
                                    !isMine ? Sizes.size20 : Sizes.size5,
                                  )),
                            ),
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.white,
              surfaceTintColor: Colors.grey.shade400,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _editingController,
                      decoration: const InputDecoration(
                        hintText: "Send a message...",
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              Sizes.size20,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.faceSmile,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  IconButton(
                    onPressed: isLoading ? null : _onSendPress,
                    icon: FaIcon(
                      isLoading
                          ? FontAwesomeIcons.hourglass
                          : FontAwesomeIcons.paperPlane,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
