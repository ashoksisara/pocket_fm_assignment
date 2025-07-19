import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/widgets/loader.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,

      // This single line fixes the infinite loading issue
      progressIndicatorBuilder: (context, url, progress) {
        if (progress.totalSize != null) {
          return const Loader();
        }
        // Show error after 3 seconds if no progress
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const _ErrorWidget();
            }
            return const Loader();
          },
        );
      },
      errorWidget: (context, url, error) => const _ErrorWidget(),
      memCacheWidth: 400,
      memCacheHeight: 300,
      maxWidthDiskCache: 400,
      maxHeightDiskCache: 300,
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      color: colorScheme.errorContainer,
      child: Icon(
        Icons.broken_image,
        color: colorScheme.onErrorContainer,
        size: 64,
      ),
    );
  }
}
