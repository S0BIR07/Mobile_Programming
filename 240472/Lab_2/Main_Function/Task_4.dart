void main(List<String> args){
  double sum=0;
  int count=0;
  if (args.isNotEmpty){
    for (String arg in args){
      double? number=double.tryParse(arg);
      if (number!=null){
        sum+=number;
        count++;
      }
    }
  }

  if (count>0){
    double average=sum/count;
    print("The average of numeratic arguments is: ${average}");
  }
  else{
    print("No numeritic arguments provided.");
  }
}