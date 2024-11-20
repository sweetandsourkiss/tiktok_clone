import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/views/user_bio_screen.dart';
import 'package:tiktok_clone/features/users/views/widgets/avatar.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/views/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _onPencilPressed(UserProfileModel data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserBioScreen(bio: data.bio, link: data.link),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(
                          data.name,
                        ),
                        centerTitle: true,
                        actions: [
                          IconButton(
                            onPressed: () => _onPencilPressed(data),
                            icon: const FaIcon(
                              FontAwesomeIcons.pencil,
                            ),
                          ),
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gaps.v20,
                            Avatar(
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                              uid: data.uid,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Sizes.size18,
                                  ),
                                ),
                                Gaps.h5,
                                FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: Sizes.size16,
                                  color: Colors.blue.shade500,
                                ),
                              ],
                            ),
                            Gaps.v24,
                            SizedBox(
                              height: Sizes.size52,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "97",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v3,
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      )
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade400,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "10M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v3,
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      )
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade400,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "194.3M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v3,
                                      Text(
                                        "Likes",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size12,
                                    horizontal: Sizes.size48,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        Sizes.size4,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Follow",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Gaps.h5,
                                Container(
                                  padding: const EdgeInsets.all(
                                    Sizes.size10 + Sizes.size1,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey.shade400,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        Sizes.size4,
                                      ),
                                    ),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.youtube,
                                  ),
                                ),
                                Gaps.h5,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size16,
                                    horizontal: Sizes.size20,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey.shade400,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        Sizes.size4,
                                      ),
                                    ),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.caretDown,
                                    size: Sizes.size14,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size32,
                              ),
                              child: Text(
                                "All highlights and where to watch live matches on FIFA+",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  "https://nomadcoders.co",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(children: [
                    GridView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: 20,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: Sizes.size2,
                        mainAxisSpacing: Sizes.size2,
                        childAspectRatio: 9 / 14,
                      ),
                      itemBuilder: (context, index) => Stack(
                        children: [
                          Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 9 / 14,
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: 'assets/images/placeholder.jpg',
                                  image:
                                      'https://images.unsplash.com/photo-1729167318434-5cefa05fa3ad?q=80&w=1971&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                ),
                              ),
                            ],
                          ),
                          const Positioned(
                            left: 4,
                            bottom: 4,
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.play,
                                  color: Colors.white,
                                  size: Sizes.size16,
                                ),
                                Gaps.h4,
                                Text(
                                  "4.1M",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Center(
                      child: Text("page two"),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        );
  }
}
