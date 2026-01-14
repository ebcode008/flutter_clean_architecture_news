part of 'article_detail_bloc.dart';

sealed class ArticleDetailState {}

class ArticleDetailLoading extends ArticleDetailState {}

class ArticleDetailLoaded extends ArticleDetailState {
  final Article article;

  ArticleDetailLoaded(this.article);
}

class ArticleDetailFailure extends ArticleDetailState {
  final Failure failure;

  ArticleDetailFailure({required this.failure});
}
