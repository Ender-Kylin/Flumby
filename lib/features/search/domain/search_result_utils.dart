import '../../library/domain/library_models.dart';

class SearchResultGroup {
  const SearchResultGroup({
    required this.id,
    required this.title,
    required this.items,
  });

  final String id;
  final String title;
  final List<MediaItemSummary> items;

  MediaItemSummary get primaryItem => items.first;

  bool get isClustered => items.length > 1 || primaryItem.isSeries;

  int get relatedEpisodeCount =>
      items.where((item) => item.mediaType == 'Episode').length;
}

List<MediaItemSummary> refineSearchResults(
  List<MediaItemSummary> items,
  String query,
) {
  final normalizedQuery = _normalizeSearchText(query);
  if (normalizedQuery.isEmpty) {
    return items;
  }

  final strictMatches = items.where(
    (item) => _searchableTexts(
      item,
    ).any((text) => _normalizeSearchText(text).contains(normalizedQuery)),
  );
  final effectiveItems = strictMatches.isNotEmpty
      ? strictMatches.toList()
      : items;

  final grouped = <String, List<MediaItemSummary>>{};
  for (final item in effectiveItems) {
    grouped
        .putIfAbsent(item.searchGroupId, () => <MediaItemSummary>[])
        .add(item);
  }

  final orderedGroupEntries = grouped.entries.toList()
    ..sort((left, right) {
      final leftScore = left.value
          .map((item) => _relevanceScore(item: item, query: normalizedQuery))
          .fold<int>(0, (best, score) => score > best ? score : best);
      final rightScore = right.value
          .map((item) => _relevanceScore(item: item, query: normalizedQuery))
          .fold<int>(0, (best, score) => score > best ? score : best);
      if (leftScore != rightScore) {
        return rightScore.compareTo(leftScore);
      }

      final leftSeries = left.value.any((item) => item.isSeries);
      final rightSeries = right.value.any((item) => item.isSeries);
      if (leftSeries != rightSeries) {
        return leftSeries ? -1 : 1;
      }

      return left.value.first.searchGroupTitle.compareTo(
        right.value.first.searchGroupTitle,
      );
    });

  return [
    for (final entry in orderedGroupEntries)
      ..._sortGroupItems(entry.value, normalizedQuery),
  ];
}

List<SearchResultGroup> buildSearchResultGroups(List<MediaItemSummary> items) {
  final grouped = <String, List<MediaItemSummary>>{};
  for (final item in items) {
    grouped
        .putIfAbsent(item.searchGroupId, () => <MediaItemSummary>[])
        .add(item);
  }

  return grouped.entries
      .map(
        (entry) => SearchResultGroup(
          id: entry.key,
          title: entry.value.first.searchGroupTitle,
          items: entry.value,
        ),
      )
      .toList(growable: false);
}

List<MediaItemSummary> _sortGroupItems(
  List<MediaItemSummary> items,
  String normalizedQuery,
) {
  final sortedItems = [...items]
    ..sort((left, right) {
      final leftScore = _relevanceScore(item: left, query: normalizedQuery);
      final rightScore = _relevanceScore(item: right, query: normalizedQuery);
      if (leftScore != rightScore) {
        return rightScore.compareTo(leftScore);
      }

      if (left.isSeries != right.isSeries) {
        return left.isSeries ? -1 : 1;
      }

      return left.title.compareTo(right.title);
    });

  return sortedItems;
}

Iterable<String> _searchableTexts(MediaItemSummary item) sync* {
  yield item.title;
  yield item.searchGroupTitle;
  if (item.overview.isNotEmpty) {
    yield item.overview;
  }
}

int _relevanceScore({required MediaItemSummary item, required String query}) {
  final normalizedTitle = _normalizeSearchText(item.title);
  final normalizedGroupTitle = _normalizeSearchText(item.searchGroupTitle);

  var score = 0;
  if (normalizedGroupTitle == query) {
    score += 120;
  } else if (normalizedGroupTitle.startsWith(query)) {
    score += 90;
  } else if (normalizedGroupTitle.contains(query)) {
    score += 70;
  }

  if (normalizedTitle == query) {
    score += 80;
  } else if (normalizedTitle.startsWith(query)) {
    score += 55;
  } else if (normalizedTitle.contains(query)) {
    score += 40;
  }

  if (item.isSeries) {
    score += 18;
  } else if (item.mediaType == 'Episode') {
    score += 8;
  }

  if (item.isFavorite) {
    score += 3;
  }

  return score;
}

String _normalizeSearchText(String value) {
  return value.toLowerCase().replaceAll(RegExp(r'\s+'), '');
}
