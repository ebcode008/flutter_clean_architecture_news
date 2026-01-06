import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/core/error/failures.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getNewsArticles();
  Future<Either<Failure, List<Article>>> getSavedArticles();
  Future<Either<Failure, bool>> saveArticle(Article article);
  Future<Either<Failure, bool>> deleteArticle(Article article);
}
