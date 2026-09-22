void main(List<String> args){
  if (args.length==2){
    print ("Correct number of arguments");
  }
  else{
    print("Usage Warning: Expected exactly 2 arguments, but received ${args.length}.");
    print("Usage: dart Task_5.dart <arg1> <arg2>");
  }
}