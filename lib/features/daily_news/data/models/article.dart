import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
    super.favorite,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    author: json['author'],
    title: json['title'],
    description: json['description'],
    url: json['url'],
    urlToImage: json['urlToImage'],
    content: json['content'],
    favorite: json['favorite'],
    publishedAt: json['publishedAt'] != null ? DateTime.parse(json['publishedAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'favorite': favorite,
    'publishedAt': publishedAt?.toIso8601String(),
    'content': content,
  };

  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      content: article.content,
      publishedAt: article.publishedAt,
      favorite: article.favorite,
    );
  }
}
