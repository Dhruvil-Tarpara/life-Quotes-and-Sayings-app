import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/globals/globals.dart';
import 'package:quotes/helper/quotes_db_helper.dart';
import 'package:quotes/models/model.dart';
import 'package:quotes/widget/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;

  @override
  Widget build(BuildContext context) {

   var size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                color: const Color(0xff5670BD),
                alignment: Alignment.center,
                child: Text(
                  "Life Quotes and\nSayings",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abel(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              ...drawerItems.map(
                    (e) => ListTile(
                  onTap: () {
                    if (e.title == "By Topic") {
                      Global.isAuthorCategory = false;
                      Navigator.of(context).pushNamed("list_page");
                    } else if (e.title == "By Author") {
                      Global.isAuthorCategory = true;
                      Navigator.of(context).pushNamed("list_page");
                    }
                  },
                  leading: Icon(
                    e.icon,
                    color: e.color,
                    size: 25,
                  ),
                  title: Text(
                    e.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff666666),
                    ),
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  "Communicate",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff666666),
                  ),
                ),
              ),
              ...drawerItems2.map(
                    (e) => ListTile(
                  onTap: () {},
                  leading: Icon(
                    e.icon,
                    color: const Color(0xff666666),
                    size: 25,
                  ),
                  title: Text(
                    e.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff666666),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Quotes"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                size: 24,
                color: Colors.white,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: QuotesDB.quotesDB.fetchAllRecords(tableName: "Latest"),
              builder: (context, snapShot) {
                if (snapShot.hasError) {
                  return Center(
                    child: Text("${snapShot.error}"),
                  );
                } else if (snapShot.hasData) {
                  List<QuotesD>? res = snapShot.data;

                  return InkWell(
                    onTap: () {
                      Global.selectedQuote = res![index];
                      Navigator.of(context).pushNamed("details_page");
                    },
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: size.height * 0.24,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: const Duration(milliseconds: 600),
                      ),
                      items: res?.map((e) {
                        return Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.hardLight,
                              ),
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                e.image,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          child: Text(
                            e.quot,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Widgets.widgets.button(
                  text: "Categories",
                  icons: const Icon(
                    Icons.api_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                Widgets.widgets.button(
                  text: "Pic Quotes",
                  icons: const Icon(
                    Icons.photo,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                Widgets.widgets.button(
                  text: "Latest",
                  icons: const Icon(
                    Icons.fiber_new,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                Widgets.widgets.button(
                  text: "Articles",
                  icons: const Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Most Popular",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Global.isAuthor = false;
                            Global.tableName = "Wisdom";
                            Navigator.of(context).pushNamed("quotes_page");
                          },
                          child: Widgets.widgets.containers(
                            text: "Wisdom",
                            h: 120,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Global.isAuthor = false;
                            Global.tableName = "Business";
                            Navigator.of(context).pushNamed("quotes_page");
                          },
                          child: Widgets.widgets.containers(
                            text: "Business",
                            h: 120,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Global.isAuthor = false;
                            Global.tableName = "Learning";
                            Navigator.of(context).pushNamed("quotes_page");
                          },
                          child: Widgets.widgets.containers(
                            text: "Learning",
                            h: 120,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(

                          onTap: () {
                            Global.isAuthor = false;
                            Global.tableName = "Life";
                            Navigator.of(context).pushNamed("quotes_page");
                          },
                          child: Widgets.widgets.containers(
                            text: "Life",
                            h: 120,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Quotes by Author",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Global.isAuthorCategory = true;
                            Navigator.of(context)
                                .pushNamed("list_of_cat_and_author_page");
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Global.isAuthor = true;
                            Global.tableName = "albert_einstein";
                            Navigator.of(context).pushNamed("quotes_page");
                          },
                          child: Widgets.widgets.containers(
                            text: "Albert\nEinstein",
                            h: 120,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Global.isAuthor = true;
                            Global.tableName = "elon_musk";
                            Navigator.of(context).pushNamed("quotes_page");
                          },
                          child: Widgets.widgets.containers(
                            text: "Elon\nMusk",
                            h: 120,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Global.isAuthor = true;
                            Global.tableName = "TedWilliams";
                            Navigator.of(context).pushNamed("quotes_page");
                          },
                          child: Widgets.widgets.containers(
                            text: "TedWilliams",
                            h: 120,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Global.isAuthor = true;
                            Global.tableName = "dr_seuss";
                            Navigator.of(context).pushNamed("quotes_page");
                          },
                          child: Widgets.widgets.containers(
                            text: "dr_seuss",
                            h: 120,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
