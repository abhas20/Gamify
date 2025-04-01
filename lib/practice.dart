
void main(){
  print("Hello World");
  // var name=stdin.readLineSync();
  int? a=3;
  a??=4;
  print(a);

}

class Car{
  late int number;
  String name="kiop";
  Car(int num){
    this.number=num;
    print(number);
  }
  void getName(){
    print(name);
  }
  
}