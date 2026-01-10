import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/data/data_sources/local/article_local.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/data/data_sources/remote/article_remote.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;
  final ArticleLocalDataSource articleLocalDataSource;

  ArticleRepositoryImpl({required this.articleRemoteDataSource, required this.articleLocalDataSource});

  @override
  Future<Either<Failure, List<Article>>> getNewsArticles() async {
    try {
      final List<Article> resp = await articleRemoteDataSource.getNewsArticles(
        apiKey: 'ff957763c54c44d8b00e5e082bc76cb0',
        category: 'general',
        country: 'us',
      );
      return Right(resp);
    } on DioException catch (err) {
      debugPrint(err.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getSavedArticles() async {
    try {
      final List<Article> resp = await articleLocalDataSource.getSavedArticles();
      return Right(resp);
    } catch (err) {
      debugPrint(err.toString());
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteArticle(Article article) async {
    try {
      final bool resp = await articleLocalDataSource.deleteArticle(article);
      return Right(resp);
    } catch (err) {
      debugPrint(err.toString());
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveArticle(Article article) async {
    try {
      final bool resp = await articleLocalDataSource.saveArticle(article);
      return Right(resp);
    } catch (err) {
      debugPrint(err.toString());
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> getSavedArticle(String title) async {
    try {
      final Article resp = await articleLocalDataSource.getSavedArticle(title);
      return Right(resp);
    } catch (err) {
      debugPrint(err.toString());
      return Left(LocalFailure());
    }
  }
}
