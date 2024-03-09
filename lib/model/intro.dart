
class Intro {
  String title;
  String description;
  String image;

  Intro({required this.title, required this.description, required this.image});
}

List<Intro> introData = [
  Intro(
      title: 'Choose Product',
      description: 'A product is the item',
      image: 'assets/files/choose.png'),
  Intro(
      title: 'Choose Product',
      description: 'A product is the item',
      image: 'assets/files/get-your-order.png'),
  Intro(
      title: 'Choose Product',
      description: 'A product is the item',
      image: 'assets/files/make-payment.png'),
];
