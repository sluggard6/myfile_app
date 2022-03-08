main() {
  String input = "HKG 007.jpg";
  RegExp exp = new RegExp(r"[0-9]+");
  // RegExp exp = new RegExp(r"\d+");
  exp.allMatches(input).forEach((element) {
    print("${element.start} : ${element.end}");
    // print();
    String s = input.substring(element.start, element.end);
    print(s);
  });
}
