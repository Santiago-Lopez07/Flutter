import 'dart:io';

main(List<String> args) {
  Directory dir = Directory("..");
  var list = dir.listSync();
  print("\t- family: Montserrat");
  print("\t\tfonts:");
  for (var item in list) {
    if (item.path.contains(".ttf")) {
      File file = File(item.path);

      String fileName = file.path.split(Platform.pathSeparator).last;

      print("\t\t\t- asset: fonts/${fileName}");
    }
  }
}
