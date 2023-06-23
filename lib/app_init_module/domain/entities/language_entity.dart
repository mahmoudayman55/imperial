class SpeakingLanguage {
  final String name;
  final int id;

  SpeakingLanguage({required this.name,required this.id});


  @override
  toString() {
    return name;
  }
}