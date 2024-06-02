import 'package:html/parser.dart' show parse;

class Utils {
  static String stripHtml(String htmlString) {
    var document = parse(htmlString);
    String parsedString =
        parse(document.body?.text ?? '').documentElement?.text ?? '';
    return parsedString;
  }
}
