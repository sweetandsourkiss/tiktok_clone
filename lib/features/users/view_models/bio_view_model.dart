import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class BioViewModel extends AsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> updateBio(String? bio, String? link) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(usersProvider.notifier).onBioUpdate(bio, link),
    );
  }
}

final bioProvider = AsyncNotifierProvider<BioViewModel, void>(
  () => BioViewModel(),
);
