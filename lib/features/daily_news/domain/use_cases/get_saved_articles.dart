import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticlesUseCase {
  final ArticleRepository repository;

  GetSavedArticlesUseCase(this.repository);

  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getSavedArticles();
  }
}
