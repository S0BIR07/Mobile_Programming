void main(){
  String name="Muhammadsobir";
  String? secondName=null;
  String mixName=secondName ?? "No second name";
  print("Name: ${name};\nSecond name: ${mixName};\n");
  secondName="Musashayxov";
  String mixName2 = secondName;
  print("Name: ${name};\nSecond name: ${mixName2}.");
}