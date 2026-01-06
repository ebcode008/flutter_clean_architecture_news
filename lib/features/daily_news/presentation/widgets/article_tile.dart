import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleTile({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _buildArticle();
  }

  Widget _buildArticle() {
    return (article.urlToImage.toString().contains('https'))
        ? InkWell(
            onTap: () => onTap(),
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: double.infinity,
              height: 200.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      width: 120.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                      imageUrl: article.urlToImage ?? '',
                      httpHeaders: const {
                        'User-Agent':
                            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
                        'Accept': 'image/avif,image/webp,image/apng,image/*,*/*;q=0.8',
                      },
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(article.title ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(article.description ?? '', overflow: TextOverflow.clip),
                            ),
                          ),
                          Text(article.publishedAt.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
