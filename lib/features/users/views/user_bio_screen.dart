import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/view_models/bio_view_model.dart';

class UserBioScreen extends ConsumerStatefulWidget {
  final String bio;
  final String link;

  const UserBioScreen({
    super.key,
    required this.bio,
    required this.link,
  });

  @override
  ConsumerState<UserBioScreen> createState() => _UserBioScreenState();
}

class _UserBioScreenState extends ConsumerState<UserBioScreen> {
  late final TextEditingController _bioController;
  late final TextEditingController _linkController;

  @override
  void initState() {
    _bioController = TextEditingController(text: widget.bio);
    _linkController = TextEditingController(text: widget.link);
    super.initState();
  }

  void _onSaveTap(WidgetRef ref) async {
    if (_bioController.value.text != "" || _linkController.value.text != "") {
      await ref
          .read(bioProvider.notifier)
          .updateBio(_bioController.value.text, _linkController.value.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          content: Text(
            "Bio updated",
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Bio"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bio",
              style: TextStyle(
                fontSize: Sizes.size24,
              ),
            ),
            Gaps.v8,
            TextField(
              maxLines: 3,
              controller: _bioController,
              decoration: InputDecoration(
                hintText: "Your Bio",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v12,
            const Text(
              "Link",
              style: TextStyle(
                fontSize: Sizes.size24,
              ),
            ),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                hintText: "Your Link",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v24,
            GestureDetector(
              onTap: () => _onSaveTap(ref),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size12,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
