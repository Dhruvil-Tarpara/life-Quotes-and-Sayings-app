import 'package:quotes/models/model.dart';

class Global
{
  static String tableName = "";
  static QuotesD? selectedQuote;
  static bool isAuthor = false;
  static bool isAuthorCategory = false;
 static List<Category> quoteCategory = [
    Category(category: "business", title: "Business"),
    Category(category: "competition", title: "Competition"),
    Category(category: "Latest", title: "Famous Quotes"),
    Category(category: "friendship", title: "Friendship"),
    Category(category: "future", title: "Future"),
    Category(category: "inspirational", title: "Inspirational"),
    Category(category: "life", title: "Life"),
    Category(category: "love", title: "Love"),
    Category(category: "motivational", title: "Motivational"),
    Category(category: "sports", title: "Sports"),
    Category(category: "wisdom", title: "Wisdom"),
  ];


  static List<Category> authorCategory = [
    Category(category: "albert_einstein", title: "Albert Einstein"),
    Category(category: "AnnaPavlova", title: "AnnaPavlova"),
    Category(category: "chanakya", title: "Chanakya"),
    Category(category: "DesmondTutu", title: "DesmondTutu"),
    Category(category: "donald_trump", title: "Donald Trump"),
    Category(category: "dr_seuss", title: "Dr Seuss"),
    Category(category: "elon_musk", title: "Elon Musk"),
    Category(category: "MichaelJordan", title: "MichaelJordan"),
    Category(category: "MuhammadAli", title: "MuhammadAli"),
    Category(category: "robert_griffin_iii", title: "Robert Griffin Iii"),
    Category(category: "TedWilliams", title: "TedWilliams"),
  ];
}

class Category{
  String category;
  String title;

  Category({required this.category, required this.title});
}
