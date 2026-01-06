part of 'article_detail_bloc.dart';

abstract class ArticleDetailEvent {}

class InitArticleDetail extends ArticleDetailEvent {
  final Article article;

  InitArticleDetail(this.article);
}

class OnSaveArticle extends ArticleDetailEvent {
  final Article article;

  OnSaveArticle(this.article);
}

class OnDeleteArticle extends ArticleDetailEvent {
  final Article article;

  OnDeleteArticle(this.article);
}
