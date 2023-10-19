import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({super.key});

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  final categoryId = TextEditingController();
  final title = TextEditingController();
  final content = TextEditingController();
  List<String> urls = [];
  double? progress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: sizeSm, right: sizeSm, top: sizeXl + sizeXl),
        child: Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(sizeXs),
                    borderSide: const BorderSide(width: 200),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Create Post',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: sizeLg),
                  ),
                  const SizedBox(height: sizeXs),
                  InputFields(controller: categoryId, hintText: 'categ-temp'),
                  const SizedBox(height: sizeXs),
                  InputFields(controller: title, hintText: 'Title'),
                  const SizedBox(height: sizeXs),
                  InputFields(
                    controller: content,
                    hintText: 'Write Something...',
                    isContent: true,
                  ),
                ],
              ),
            ),
            if (progress != null) ...[
              const SizedBox(height: 4),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 20),
            ],
            EditMultipleMedia(
                urls: urls,
                onDelete: (e) async {
                  await StorageService.instance.delete(e);
                  setState(() {
                    urls.remove(e);
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    final url = await StorageService.instance.upload(
                      context: context,
                      progress: (p) => setState(() => progress = p),
                      complete: () => setState(() => progress = null),
                      camera: PostService.instance.uploadFromCamera,
                      gallery: PostService.instance.uploadFromGallery,
                      file: PostService.instance.uploadFromFile,
                    );
                    if (url != null && mounted) {
                      setState(() {
                        urls.add(url);
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 36,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Post.create(
                    categoryId: categoryId.text,
                    title: title.text,
                    content: content.text,
                    urls: urls,
                  ).then(
                    (post) {
                      context.pop();
                      return PostService.instance.showPostViewScreen(context: context, post: post);
                    },
                  ),
                  child: const Text('Post'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputFields extends StatelessWidget {
  const InputFields({
    super.key,
    required this.controller,
    required this.hintText,
    this.isContent = false,
  });
  final String hintText;
  final TextEditingController controller;
  final bool isContent;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: isContent ? 5 : 1,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
