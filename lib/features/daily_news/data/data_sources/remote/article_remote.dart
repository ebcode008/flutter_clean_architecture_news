import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/data/models/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';

abstract class ArticleRemoteDataSource {
  Future<List<Article>> getNewsArticles({required String category, required String country, required String apiKey});
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final Dio _dio = Dio();

  @override
  Future<List<Article>> getNewsArticles({
    required String category,
    required String country,
    required String apiKey,
  }) async {
    final response = await _dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {'category': category, 'country': country, 'apiKey': apiKey},
    );

    final List articlesJson = response.data['articles'];

    final articles = articlesJson.map((json) => ArticleModel.fromJson(json)).toList();

    return articles;
  }
}
