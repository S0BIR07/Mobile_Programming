void main(List<String> args) {
  if (args.isNotEmpty){
    print("Number of arguments: ${args.length}");
  }
  else{
    print("No arguments provided.");
  }
}