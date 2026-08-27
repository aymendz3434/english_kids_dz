class WordItem {
  final String word, image;
  const WordItem(this.word, this.image);
}
class Lesson {
  final String type, title, emoji;
  final List<WordItem> items;
  const Lesson(this.type, this.title, this.emoji, this.items);
}
class Module {
  final String title;
  final List<Lesson> lessons;
  const Module(this.title, this.lessons);
}
class SchoolYear {
  final int year;
  final String title, emoji;
  final List<Module> modules;
  const SchoolYear(this.year, this.title, this.emoji, this.modules);
}
class Question {
  final String question, image, skill;
  final List<String> answers;
  final int correct;
  const Question(this.question, this.image, this.skill, this.answers, this.correct);
}
class Curriculum {
  static const img = {
    'apple': 'assets/images/apple.jpg', 'banana': 'assets/images/banana.jpg',
    'orange': 'assets/images/orange.jpg', 'bread': 'assets/images/bread.jpg',
    'milk': 'assets/images/milk.jpg',water': 'assets/images/water.jpg',
    'cat': 'assets/images/cat.jpg', 'dog': 'assets/images/dog.jpg',
    'cow': 'assets/images/cow.jpg', 'lion': 'assets/images/lion.jpg',
    'sun': 'assets/images/sun.jpg', 'rain': 'assets/images/rain.jpg',
    'clouds': 'assets/images/clouds.jpg', 'car': 'assets/images/car.jpg',
 'bus': 'assets/images/bus.jpg', 'bike': 'assets/images/bike.jpg',
    'train': 'assets/images/train.jpg', 'boat': 'assets/images/boat.jpg',
    'school': 'assets/images/school.jpg', 'park': 'assets/images/park.jpg',
    'mosque': 'assets/images/mosque.jpg', 'shirt': 'assets/images/shirt.jpg',
  };

  static final years = [
    SchoolYear(3, 'Year 3', '🐣', [
      Module('Food & Drinks', [
        Lesson('Vocabulary', 'Fruits & Food', '🍎', const [
          WordItem('Apple', img['apple']!), WordItem('Banana', img['banana']!),
          WordItem('Orange', img['orange']!), WordItem('Bread', img['bread']!),
        ]),
        Lesson('Vocabulary', 'Drinks', '🥛', const [
          WordItem('Milk', img['milk']!), WordItem('Water', img['water']!),
        ]),
        Lesson('Dialogue', 'I like / I do not like', '💬', const [
          WordItem('I like apples.', '💬'), WordItem('I do not like bananas.', '💬'),
        ]),
      ]),
      Module('Animals', [
        Lesson('Vocabulary', 'Animals', '🦁', const [
          WordItem('Cat', img['cat']!), WordItem('Dog', img['dog']!),
          WordItem('Cow', img['cow!), WordItem('Lion', img['lion']!),
        ]),
      ]),
      Module('Clothes',        Lesson('Vocabulary', 'Clothes', '👕', const [
          WordItem('Shirt', img['shirt']!),
        ]),
      ]),
    ]),
    SchoolYear(4, 'Year 4', '🦅', [
      Module('Days of the Week', [
        Lesson('Vocabulary', 'Days', '📅', const [
          WordItem('Monday', '1️⃣'), WordItem('Tuesday', '2️⃣'),
          WordItem('Wednesday',3️⃣'), WordItem('Thursday', '4️⃣'),
          WordItem('Friday', '5️⃣'), WordItem('Saturday '6️⃣'),
          WordItem('Sunday', '7️⃣'),
        ]),
      ]),
      Module('Weather', [
        Lesson('Vocabulary', 'Weather', '⛅', const [
          WordItem('Sunny', img['sun']!), WordItem('Rainy', img['rain']!),
          WordItem('Cloudy', img['clouds']!),
        ]),
      ]),
    ]),
    SchoolYear(5, 'Year 5', '🦁', [
      Module('My Town', [
        Lesson('Vocabulary', 'Places', '🏙️', const [
          WordItem('School', img['school']!), WordItem('Park', img['park']!),
          WordItem('Mosque', img['mosque']!),
        ]),
      ]),
      Module('Transport', [
        Lesson('Vocabulary', 'Transport', '🚗', const [
          WordItem('Car', img['car']!), WordItem('Bus', img['bus']!),
          WordItem('Bike', img['bike']!), WordItem('Train', img['train']!),
          WordItem('Boat', img['boat']!),
        ]),
      ]),
    ]),
  ];

  static final questions = [
    Question('This fruit is an...', img['apple']!, 'Circle', ['Apple', 'Banana', 'Bread'], 0),
    Question('This drink is...', img['milk']!, 'Circle', ['Water', 'Milk', 'Juice'], 1),
    Question('This animal is a...', img['cow']!, 'Match', ['Cat', 'Dog', 'Cow'], 2),
    Question('The weather is...', img['rain']!, 'Describe', ['Sunny', 'Rainy', 'Cloudy'], 1),
    Question('We ride a...', img['bike']!, 'Circle', ['Car', 'Plane', 'Bike'], 2),
    Question('This place is a...', img['mosque']!, 'Circle', ['School', 'Mos', 'Hospital'], 1),
  ];
}
