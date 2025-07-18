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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Loader(),
      errorWidget: (context, url, error) => Container(
        color: colorScheme.errorContainer,
        child: Icon(
          Icons.broken_image,
          color: colorScheme.onErrorContainer,
          size: 64,
        ),
      ),
      memCacheWidth: 400,
      memCacheHeight: 300,
      maxWidthDiskCache: 400,
      maxHeightDiskCache: 300,
    );
  }
}
