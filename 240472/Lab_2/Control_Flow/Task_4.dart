void main(){
  int number=42;
  int guess=0;
  while(true){
    guess++;
    print("Guessing: $guess");
    if (guess==number){
      print("Found the number: $guess");
      break;
    }
  }
}