void main(){
  int num=5;
  int fact=1;
  int fact1=1;
  List<int> list=[1,2,3,4,5];
  for(int i=1; i<=num; i++){

    fact=fact*i;
  }
  for(int number in list){
    fact1=fact1*number;
  }
  print("Factorial of $num using for loop is ${fact}");
  print("Factorial of $num using for-in loop is ${fact1}");
}