import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UserListViewModel extends AsyncNotifier<List<UserProfileModel>> {
  late final UserRepository _userRepository;

  @override
  FutureOr<List<UserProfileModel>> build() async {
    _userRepository = ref.read(userRepo);
    return await _userRepository.getUsers();
  }
}

final userListProvider =
    AsyncNotifierProvider<UserListViewModel, List<UserProfileModel>>(
  () => UserListViewModel(),
);
