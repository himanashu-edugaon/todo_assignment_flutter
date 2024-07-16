extension Formates on String{
  String get capitalize{
    var data = split('');
    data[0] = data[0].toUpperCase();
    var finalString = data.join();
    return finalString;
   }
}