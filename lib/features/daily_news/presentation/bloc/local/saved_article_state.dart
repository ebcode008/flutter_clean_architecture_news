part of 'saved_article_bloc.dart';

sealed class SavedArticleState {}

final class SavedArticleLoading extends SavedArticleState {}

final class SavedArticleLoaded extends SavedArticleState {
  final List<Article> articles;

  SavedArticleLoaded({required this.articles});
}

final class SavedArticleFailure extends SavedArticleState {
  final Failure failure;

  SavedArticleFailure({required this.failure});
}
