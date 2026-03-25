import 'package:flutter/material.dart';

import '../../features/library/domain/library_models.dart';

class MediaArtwork extends StatelessWidget {
  const MediaArtwork({
    this.aspectRatio,
    this.imageUrl,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.overlay,
    super.key,
  });

  final double? aspectRatio;
  final String? imageUrl;
  final BorderRadius borderRadius;
  final BoxFit fit;
  final Alignment alignment;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    final placeholder = DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1C2733), Color(0xFF121B24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: borderRadius,
      ),
      child: const Center(
        child: Icon(
          Icons.ondemand_video_rounded,
          color: Colors.white38,
          size: 34,
        ),
      ),
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: aspectRatio == null
          ? _ArtworkStack(
              placeholder: placeholder,
              imageUrl: imageUrl,
              fit: fit,
              alignment: alignment,
              overlay: overlay,
            )
          : AspectRatio(
              aspectRatio: aspectRatio!,
              child: _ArtworkStack(
                placeholder: placeholder,
                imageUrl: imageUrl,
                fit: fit,
                alignment: alignment,
                overlay: overlay,
              ),
            ),
    );
  }
}

class _ArtworkStack extends StatelessWidget {
  const _ArtworkStack({
    required this.placeholder,
    required this.imageUrl,
    required this.fit,
    required this.alignment,
    required this.overlay,
  });

  final Widget placeholder;
  final String? imageUrl;
  final BoxFit fit;
  final Alignment alignment;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        placeholder,
        if (imageUrl != null && imageUrl!.isNotEmpty)
          Image.network(
            imageUrl!,
            fit: fit,
            alignment: alignment,
            errorBuilder: (context, error, stackTrace) => placeholder,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return placeholder;
            },
          ),
        ...[overlay].whereType<Widget>(),
      ],
    );
  }
}

class PosterMediaCard extends StatelessWidget {
  const PosterMediaCard({
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.progress,
    this.isFavorite = false,
    this.onTap,
    super.key,
  });

  static const double cardWidth = 176;
  static const double cardHeight = 336;

  final String title;
  final String? subtitle;
  final String? imageUrl;
  final double? progress;
  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasProgress = progress != null && progress! > 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compactLayout = constraints.maxHeight <= cardHeight;
        final showSubtitle =
            subtitle != null &&
            subtitle!.isNotEmpty &&
            constraints.maxHeight >= 360 &&
            constraints.maxWidth >= 190;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: scheme.outlineVariant.withValues(alpha: 0.18),
                ),
              ),
              padding: EdgeInsets.all(compactLayout ? 10 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        MediaArtwork(
                          imageUrl: imageUrl,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        if (isFavorite)
                          const Positioned(
                            top: 10,
                            right: 10,
                            child: Icon(
                              Icons.favorite_rounded,
                              color: Color(0xFFFF6A82),
                              size: 18,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: compactLayout ? 10 : 12),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  if (showSubtitle) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.0,
                      ),
                    ),
                  ],
                  if (hasProgress) ...[
                    SizedBox(height: compactLayout ? 8 : 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress!.clamp(0, 1),
                        minHeight: 4,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class WideMediaCard extends StatelessWidget {
  const WideMediaCard({
    required this.title,
    required this.progressText,
    this.subtitle,
    this.imageUrl,
    this.progress,
    this.onTap,
    super.key,
  });

  final String title;
  final String progressText;
  final String? subtitle;
  final String? imageUrl;
  final double? progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.18),
            ),
          ),
          child: Stack(
            children: [
              MediaArtwork(
                imageUrl: imageUrl,
                aspectRatio: 16 / 9,
                borderRadius: BorderRadius.circular(28),
                overlay: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.06),
                        Colors.black.withValues(alpha: 0.72),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                    if (progress != null) ...[
                      const SizedBox(height: 14),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: progress!.clamp(0, 1),
                          minHeight: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.14),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        progressText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibrarySelectionCard extends StatelessWidget {
  const LibrarySelectionCard({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    this.imageUrl,
    this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? scheme.primary
                  : scheme.outlineVariant.withValues(alpha: 0.22),
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Stack(
            children: [
              MediaArtwork(
                imageUrl: imageUrl,
                aspectRatio: 16 / 9,
                borderRadius: BorderRadius.circular(24),
                overlay: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.12),
                        Colors.black.withValues(alpha: 0.76),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 18,
                right: 18,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaPosterGrid extends StatelessWidget {
  const MediaPosterGrid({
    required this.items,
    required this.onItemTap,
    super.key,
  });

  final List<MediaItemSummary> items;
  final ValueChanged<MediaItemSummary> onItemTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = switch (width) {
          >= 1520 => 7,
          >= 1320 => 6,
          >= 1080 => 5,
          >= 860 => 4,
          >= 620 => 3,
          _ => 2,
        };

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            mainAxisExtent: PosterMediaCard.cardHeight,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            final subtitleParts = <String>[
              if (item.year != null) item.year.toString(),
              if (item.runtimeSeconds > 0)
                '${(item.runtimeSeconds / 60).round()} min',
            ];

            return PosterMediaCard(
              title: item.title,
              subtitle: subtitleParts.join(' • '),
              imageUrl:
                  item.posterImageUrl ??
                  item.thumbImageUrl ??
                  item.backdropImageUrl,
              progress: item.isResumable ? item.progress : null,
              isFavorite: item.isFavorite,
              onTap: () => onItemTap(item),
            );
          },
        );
      },
    );
  }
}
