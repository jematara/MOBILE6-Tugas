import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas4/api_service.dart';
import 'package:tugas4/article_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'news pois-corner',
      home: const NewsScreen(),
      theme: base.copyWith(
        textTheme: GoogleFonts.montserratTextTheme(base.textTheme),
        primaryTextTheme: GoogleFonts.montserratTextTheme(base.primaryTextTheme),
      ),
    );
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<Article>> articles;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    articles = ApiService().fetchArticle();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if(!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final atBottom = position.pixels >= position.maxScrollExtent - 50 && position.maxScrollExtent > 0;
    if(atBottom != _showScrollToTop) {
      setState(() => _showScrollToTop = atBottom);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      );
  }

  Future<void> _refresh() async {
    final future = ApiService().fetchArticle();
    setState(() {
      articles = future;
    });
    try {
      await future;
    } catch (_) {}
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.newspaper,
          color: Colors.brown,
        ),
        title: Text(
          'News Pois-corner',
          style: TextStyle(
            fontWeight: .bold,
            color: Colors.brown,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 183, 221, 210),
      ),
      floatingActionButton: _showScrollToTop
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: const Color.fromARGB(255, 183, 221, 210),
              foregroundColor: Colors.brown,
              child: const Icon(Icons.keyboard_arrow_up),
            )
          : null,
      body: FutureBuilder(
        future: articles,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontWeight: .bold),
              ),
            );
          }
          final data = snapshot.data ?? [];
          if(data.isEmpty){
            return const Center(
              child: Text(
                'Tidak Ada Berita',
                style: TextStyle(fontWeight: .bold),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final article = data[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: article.urlToImage != null
                        ? Image.network(
                            article.urlToImage!,
                            width: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.newspaper),
                    title: Text(article.judul),
                    subtitle: Text(
                      article.deskripsi ?? 'Tidak Ada Deskripsi',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}