class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;

  final List<String> answers;

  List<String> getshuffledanswers() {
    final shuffledlist = List.of(answers);
    shuffledlist.shuffle();
    return shuffledlist;
  }
}

List<QuizQuestion> generalKnowledgeQuestions = const [
  QuizQuestion(
    'Which country has Tegucigalpa as its capital?',
    ['Honduras', 'Bolivia', 'Peru', 'Chile'],
  ),
  QuizQuestion(
    'What is the currency of China?',
    ['Yuan', 'Rupee', 'Euro', 'Dollar'],
  ),
  QuizQuestion(
    'Who is the author of "To Kill a Mockingbird"?',
    ['Harper Lee', 'J.K. Rowling', 'Stephen King', 'George Orwell'],
  ),
  QuizQuestion(
    'Which planet is known as the Red Planet?',
    ['Mars', 'Venus', 'Jupiter', 'Saturn'],
  ),
  QuizQuestion(
    'Who painted the Mona Lisa?',
    ['Leonardo da Vinci', 'Vincent van Gogh', 'Pablo Picasso', 'Michelangelo'],
  ),
  QuizQuestion(
    'What is the largest mammal in the world?',
    ['Blue Whale', 'African Elephant', 'Giraffe', 'Hippopotamus'],
  ),
  QuizQuestion(
    'What is the chemical symbol for gold?',
    ['Au', 'Ag', 'Fe', 'Cu'],
  ),
  QuizQuestion(
    'What is the main ingredient in hummus?',
    ['Chickpeas', 'Lentils', 'Black beans', 'Kidney beans'],
  ),
  QuizQuestion(
    'Which country is known as the Land of the Rising Sun?',
    ['Japan', 'China', 'India', 'Thailand'],
  ),
  QuizQuestion(
    'Who wrote "1984"?',
    ['George Orwell', 'Aldous Huxley', 'Ray Bradbury', 'J.R.R. Tolkien'],
  ),
  QuizQuestion(
    'What is the tallest mountain in the world?',
    ['Mount Everest', 'K2', 'Kangchenjunga', 'Lhotse'],
  ),
  QuizQuestion(
    'What is the largest ocean in the world?',
    ['Pacific Ocean', 'Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean'],
  ),
  QuizQuestion(
    'What is the capital of Australia?',
    ['Canberra', 'Sydney', 'Melbourne', 'Brisbane'],
  ),
  QuizQuestion(
    'Who is known as the Father of Geometry?',
    ['Euclid', 'Pythagoras', 'Archimedes', 'Aristotle'],
  ),
  QuizQuestion(
    'What is the chemical symbol for water?',
    ['H2O', 'CO2', 'NaCl', 'O2'],
  ),
  QuizQuestion(
    'What is the largest organ in the human body?',
    ['Skin', 'Liver', 'Heart', 'Brain'],
  ),
  QuizQuestion(
    'Which country is known as the Land of Fire and Ice?',
    ['Iceland', 'Greenland', 'Norway', 'Finland'],
  ),
  QuizQuestion(
    'Who discovered the theory of evolution by natural selection?',
    ['Charles Darwin', 'Gregor Mendel', 'Louis Pasteur', 'Albert Einstein'],
  ),
  QuizQuestion(
    'What is the chemical symbol for iron?',
    ['Fe', 'Au', 'Ag', 'Cu'],
  ),
  QuizQuestion(
    'What is the boiling point of water in Celsius?',
    ['100°C', '0°C', '50°C', '200°C'],
  ),
  QuizQuestion(
    'Which city is known as the City of Love?',
    ['Paris', 'Rome', 'Venice', 'Florence'],
  ),
  QuizQuestion(
    'Who is known as the Queen of Soul?',
    ['Aretha Franklin', 'Whitney Houston', 'Tina Turner', 'Janis Joplin'],
  ),
  QuizQuestion(
    'What is the chemical symbol for silver?',
    ['Ag', 'Au', 'Fe', 'Cu'],
  ),
  QuizQuestion(
    'Who discovered gravity?',
    ['Isaac Newton', 'Albert Einstein', 'Galileo Galilei', 'Nikola Tesla'],
  ),
  QuizQuestion(
    'Which country is known as the Land of the Midnight Sun?',
    ['Norway', 'Sweden', 'Finland', 'Denmark'],
  ),
  QuizQuestion(
    'What is the chemical symbol for carbon?',
    ['C', 'Ca', 'Co', 'Cu'],
  ),
  QuizQuestion(
    'Who painted The Starry Night?',
    ['Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Claude Monet'],
  ),
  QuizQuestion(
    'What is the capital of South Korea?',
    ['Seoul', 'Tokyo', 'Beijing', 'Bangkok'],
  ),
  QuizQuestion(
    'What is the chemical symbol for sodium?',
    ['Na', 'N', 'Ni', 'Ne'],
  ),
  QuizQuestion(
    'Who composed the Ninth Symphony?',
    [
      'Ludwig van Beethoven',
      'Wolfgang Amadeus Mozart',
      'Johann Sebastian Bach',
      'Franz Schubert'
    ],
  ),
  QuizQuestion(
    'What is the capital of Brazil?',
    ['Brasília', 'Rio de Janeiro', 'São Paulo', 'Salvador'],
  ),
  QuizQuestion(
    'What is the chemical symbol for potassium?',
    ['K', 'Ka', 'Ke', 'Ko'],
  ),
  QuizQuestion(
    'Who was the first person to step on the moon?',
    ['Neil Armstrong', 'Buzz Aldrin', 'Yuri Gagarin', 'John Glenn'],
  ),
  QuizQuestion(
    'What is the chemical symbol for helium?',
    ['He', 'H', 'Hu', 'Ha'],
  ),
  QuizQuestion(
    'Who wrote the play "Hamlet"?',
    ['William Shakespeare', 'Christopher Marlowe', 'Ben Jonson', 'John Milton'],
  ),
  QuizQuestion(
    'What is the chemical symbol for oxygen?',
    ['O', 'Ox', 'On', 'Om'],
  ),
  QuizQuestion(
    'Who was the first President of the United States?',
    ['George Washington', 'Thomas Jefferson', 'Abraham Lincoln', 'John Adams'],
  ),
  QuizQuestion(
    'What is the chemical symbol for nitrogen?',
    ['N', 'Ni', 'Ne', 'Na'],
  ),
  QuizQuestion(
    'Who painted the ceiling of the Sistine Chapel?',
    ['Michelangelo', 'Leonardo da Vinci', 'Raphael', 'Donatello'],
  ),
  QuizQuestion(
    'What is the chemical symbol for lead?',
    ['Pb', 'L', 'Le', 'P'],
  ),
  QuizQuestion(
    'Who wrote "Pride and Prejudice"?',
    ['Jane Austen', 'Charlotte Brontë', 'Emily Brontë', 'F. Scott Fitzgerald'],
  ),
  QuizQuestion(
    'What is the chemical symbol for calcium?',
    ['Ca', 'C', 'Cu', 'Co'],
  ),
  QuizQuestion(
    'Who discovered electricity?',
    ['Benjamin Franklin', 'Thomas Edison', 'Nikola Tesla', 'Michael Faraday'],
  ),
  QuizQuestion(
    'What is the chemical symbol for copper?',
    ['Cu', 'C', 'Co', 'Ca'],
  ),
  QuizQuestion(
    'Who wrote "The Catcher in the Rye"?',
    ['J.D. Salinger', 'F. Scott Fitzgerald', 'Ernest Hemingway', 'Mark Twain'],
  ),
  QuizQuestion(
    'What is the chemical symbol for silver?',
    ['Ag', 'Au', 'Fe', 'Cu'],
  ),
  QuizQuestion(
    'Who was the first female Prime Minister of the United Kingdom?',
    ['Margaret Thatcher', 'Theresa May', 'Angela Merkel', 'Jacinda Ardern'],
  ),
  QuizQuestion(
    'What is the chemical symbol for tin?',
    ['Sn', 'Ti', 'T', 'Si'],
  ),
  QuizQuestion(
    'Who painted the "Mona Lisa"?',
    ['Leonardo da Vinci', 'Vincent van Gogh', 'Pablo Picasso', 'Michelangelo'],
  ),
  QuizQuestion(
    'What is the chemical symbol for uranium?',
    ['U', 'Un', 'Ur', 'Um'],
  ),
  QuizQuestion(
    'Who was the first woman to win a Nobel Prize?',
    [
      'Marie Curie',
      'Rosalind Franklin',
      'Dorothy Hodgkin',
      'Barbara McClintock'
    ],
  ),
  QuizQuestion(
    'What is the chemical symbol for mercury?',
    ['Hg', 'M', 'Me', 'Mc'],
  ),
  QuizQuestion(
    'Who wrote "The Great Gatsby"?',
    ['F. Scott Fitzgerald', 'Ernest Hemingway', 'J.D. Salinger', 'Mark Twain'],
  ),
  QuizQuestion(
    'What is the chemical symbol for silicon?',
    ['Si', 'S', 'Se', 'Sn'],
  ),
  QuizQuestion(
    'Who discovered penicillin?',
    ['Alexander Fleming', 'Louis Pasteur', 'Marie Curie', 'Isaac Newton'],
  ),
  QuizQuestion(
    'What is the chemical symbol for potassium?',
    ['K', 'Ka', 'Ke', 'Ko'],
  ),
  QuizQuestion(
    'Who was the first man to orbit the Earth?',
    ['Yuri Gagarin', 'Neil Armstrong', 'Buzz Aldrin', 'John Glenn'],
  ),
  QuizQuestion(
    'What is the chemical symbol for neon?',
    ['Ne', 'N', 'No', 'Ni'],
  ),
  QuizQuestion(
    'Who wrote "Moby-Dick"?',
    [
      'Herman Melville',
      'F. Scott Fitzgerald',
      'Ernest Hemingway',
      'Mark Twain'
    ],
  ),
  QuizQuestion(
    'What is the chemical symbol for sulfur?',
    ['S', 'Su', 'Se', 'Sn'],
  ),
  QuizQuestion(
    'Who discovered the theory of relativity?',
    ['Albert Einstein', 'Isaac Newton', 'Stephen Hawking', 'Galileo Galilei'],
  ),
  QuizQuestion(
    'What is the chemical symbol for zinc?',
    ['Zn', 'Z', 'Zi', 'Zo'],
  ),
  QuizQuestion(
    'Who was the first woman to fly solo across the Atlantic?',
    [
      'Amelia Earhart',
      'Bessie Coleman',
      'Harriet Quimby',
      'Jacqueline Cochran'
    ],
  ),
  QuizQuestion(
    'What is the chemical symbol for chromium?',
    ['Cr', 'Ch', 'Ci', 'Co'],
  ),
];
