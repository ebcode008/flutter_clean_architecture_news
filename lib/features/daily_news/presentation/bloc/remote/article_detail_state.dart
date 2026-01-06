part of 'article_detail_bloc.dart';

abstract class ArticleDetailState {}

class ArticleDetailLoading extends ArticleDetailState {}

class ArticleDetailLoaded extends ArticleDetailState {
  final Article article;

  ArticleDetailLoaded(this.article);
}

class ArticleDetailFailure extends ArticleDetailState {
  final Failure failure;

  ArticleDetailFailure(this.failure);
}
