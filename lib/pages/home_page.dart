import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/const.dart';
import 'package:cinema/data_provider/dummy_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? pageController;
  double viewPortFraction = 0.6;
  double pageOffset = 1;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: 1, viewportFraction: viewPortFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController!.page!;
            });
          });
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcom Angelina 👋',
                  style: font.copyWith(fontSize: 14, color: Colors.white70),
                ),
                Text(
                  'Let\'s relax and watch our movies',
                  style: font.copyWith(fontSize: 14, color: Colors.white),
                )
              ],
            ),
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                  image: AssetImage('assets/profile.jpg'),
                ),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            SizedBox(
              width: 340,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white24,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white24)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintText: 'Search',
                  hintStyle: font.copyWith(color: Colors.white),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 360,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: font.copyWith(color: white, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        'see all',
                        style: font.copyWith(
                          color: white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: white.withOpacity(0.7),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(DummyData.listCategory.length, (index) {
                return Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white.withOpacity(0.2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/emoticons/${DummyData.listCategory[index].emoticon}',
                        width: 30,
                        height: 30,
                      ),
                      Text(DummyData.listCategory[index].name)
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      width: 200,
                      height: 300,
                      key: UniqueKey(),
                      imageUrl: DummyData.movies[index].poster,
                      errorWidget: (context, url, err) {
                        return const Icon(Icons.error);
                      },
                      progressIndicatorBuilder: (context, url, progress) {
                        return Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
