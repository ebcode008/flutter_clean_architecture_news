import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_01/core/router/app_router.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/local/saved_article_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/remote/article_detail_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/remote/news_article_bloc.dart';
import 'package:flutter_clean_architecture_01/injection_container.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.instance.get<NewsArticleBloc>()),
        BlocProvider(create: (context) => GetIt.instance.get<SavedArticleBloc>()),
        BlocProvider(create: (context) => GetIt.instance.get<ArticleDetailBloc>()),
      ],
      child: MaterialApp.router(title: 'News App', debugShowCheckedModeBanner: false, routerConfig: router),
    );
  }
}
