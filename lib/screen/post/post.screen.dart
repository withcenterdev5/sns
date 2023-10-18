import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:sns/screen/post/post.photo.upload.dart';
import 'package:sns/widgets/stack.floating.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    PostService.instance.onCreate = (post) {
      toast(
        title: 'Post Created',
        message: 'New Post has been added.',
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PostListView(
          itemBuilder: (context, post) => InkWell(
            onTap: () => PostService.instance.showPostViewScreen(context: context, post: post),
            child: PostCard(
              post: post,
            ),
          ),
        ),
        StackFloatingButton(
          onPressed: () => showGeneralDialog(
            context: context,
            pageBuilder: (context, _, __) => const PhotoUpload(),
          ),
          labelIcon: Text(
            'New Post',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
      ],
    );
  }
}
