import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/data/models/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ArticleLocalDataSource {
  Future<List<Article>> getSavedArticles();
  Future<bool> saveArticle(Article article);
  Future<bool> deleteArticle(Article article);
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  ArticleLocalDataSourceImpl() {
    Hive.initFlutter();
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    try {
      Box<dynamic> box = await Hive.openBox('articles');
      return box.values.map((e) => ArticleModel.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (err) {
      throw LocalFailure();
    }
  }

  @override
  Future<bool> saveArticle(Article article) async {
    try {
      Box<dynamic> box = await Hive.openBox('articles');
      await box.put(article.title, ArticleModel.fromEntity(article).toJson());
      return true;
    } catch (err) {
      throw LocalFailure();
    }
  }

  @override
  Future<bool> deleteArticle(Article article) async {
    try {
      Box<dynamic> box = await Hive.openBox('articles');
      await box.delete(article.title);
      return true;
    } catch (err) {
      throw LocalFailure();
    }
  }
}
