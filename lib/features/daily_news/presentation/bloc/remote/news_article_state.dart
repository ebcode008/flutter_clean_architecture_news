part of 'news_article_bloc.dart';

sealed class NewsArticleState {}

final class NewsArticleLoading extends NewsArticleState {}

final class NewsArticleLoaded extends NewsArticleState {
  final List<Article> articles;

  NewsArticleLoaded({required this.articles});
}

final class NewsArticleFailure extends NewsArticleState {
  final Failure failure;

  NewsArticleFailure({required this.failure});
}
