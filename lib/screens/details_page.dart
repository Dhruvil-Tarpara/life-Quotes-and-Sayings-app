import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/globals/globals.dart';


class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.hardLight,
                ),
                fit: BoxFit.cover,
                image: MemoryImage(
                  Global.selectedQuote!.image,
                ),
              ),
            ),
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "${Global.selectedQuote!.quot}\n\n - ${Global.selectedQuote!.author}",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image,
                      color: Colors.purple,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                    },
                    icon: const Icon(
                      Icons.copy_rounded,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.download,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.star_border,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
