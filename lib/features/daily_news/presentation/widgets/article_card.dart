import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return _buildArticle();
  }

  Widget _buildArticle() {
    return (article.urlToImage.toString().contains('https'))
        ? Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Text(
                  article.title ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                const SizedBox(height: 10.0),
                CachedNetworkImage(
                  width: double.infinity,
                  height: 200.0,
                  fit: BoxFit.fitWidth,
                  imageUrl: article.urlToImage ?? '',
                  httpHeaders: const {
                    'User-Agent':
                        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
                    'Accept': 'image/avif,image/webp,image/apng,image/*,*/*;q=0.8',
                  },
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                ),
                const SizedBox(height: 10.0),
                Text(
                  article.description ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  article.publishedAt.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
