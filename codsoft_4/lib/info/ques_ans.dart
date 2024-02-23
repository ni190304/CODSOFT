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

final answered_ques = [];

final correctly_answered = [];

const generalKnowledgeQuestions =  [
  [
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
      [
        'Leonardo da Vinci',
        'Vincent van Gogh',
        'Pablo Picasso',
        'Michelangelo'
      ],
    ),
  ],
  [
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
  ],
  [
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
  ],
  [
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
  ],
  [
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
  ],
];

final generalKnowledgeCorrectAnswers =  [
  ['Honduras', 'Yuan', 'Harper Lee', 'Mars', 'Leonardo da Vinci'],
  ['Blue Whale', 'Au', 'Chickpeas', 'Japan', 'George Orwell'],
  ['Mount Everest', 'Pacific Ocean', 'Canberra', 'Euclid', 'H2O'],
  ['Skin', 'Iceland', 'Charles Darwin', 'Fe', '100°C'],
  ['Paris', 'Aretha Franklin', 'Ag', 'Isaac Newton', 'Norway'],
];

const movieAndTVQuestions =  [
  [
    QuizQuestion(
      'Which movie features a character named Harry Potter?',
      [
        'Harry Potter and the Philosopher\'s Stone',
        'The Lord of the Rings',
        'The Hunger Games',
        'Twilight'
      ],
    ),
    QuizQuestion(
      'Who played the character of Tony Stark in the Marvel Cinematic Universe?',
      ['Robert Downey Jr.', 'Chris Hemsworth', 'Chris Evans', 'Mark Ruffalo'],
    ),
    QuizQuestion(
      'Which TV series follows the lives of the Stark, Lannister, and Targaryen families?',
      ['Game of Thrones', 'Breaking Bad', 'Stranger Things', 'The Crown'],
    ),
    QuizQuestion(
      'Who directed the movie "Inception"?',
      [
        'Christopher Nolan',
        'Steven Spielberg',
        'Martin Scorsese',
        'Quentin Tarantino'
      ],
    ),
    QuizQuestion(
      'Which actor played the role of Jack Dawson in the movie "Titanic"?',
      ['Leonardo DiCaprio', 'Brad Pitt', 'Tom Cruise', 'Johnny Depp'],
    ),
  ],
  [
    QuizQuestion(
      'Which movie won the Academy Award for Best Picture in 2020?',
      ['Parasite', '1917', 'Joker', 'Once Upon a Time in Hollywood'],
    ),
    QuizQuestion(
      'Which TV series is set in the fictional town of Hawkins, Indiana?',
      ['Stranger Things', 'The Walking Dead', 'Breaking Bad', 'Black Mirror'],
    ),
    QuizQuestion(
      'Who portrayed the character of Katniss Everdeen in the "Hunger Games" movies?',
      [
        'Jennifer Lawrence',
        'Emma Watson',
        'Scarlett Johansson',
        'Margot Robbie'
      ],
    ),
    QuizQuestion(
      'Which movie features a character named Gollum?',
      [
        'The Lord of the Rings',
        'Harry Potter and the Chamber of Secrets',
        'Avatar',
        'The Matrix'
      ],
    ),
    QuizQuestion(
      'Who directed the movie "The Shawshank Redemption"?',
      [
        'Frank Darabont',
        'Quentin Tarantino',
        'Steven Spielberg',
        'Martin Scorsese'
      ],
    ),
  ],
  [
    QuizQuestion(
      'Which TV series is set in the fictional town of Springfield?',
      ['The Simpsons', 'Family Guy', 'South Park', 'Bob\'s Burgers'],
    ),
    QuizQuestion(
      'Who played the role of Neo in the movie "The Matrix"?',
      ['Keanu Reeves', 'Tom Cruise', 'Brad Pitt', 'Leonardo DiCaprio'],
    ),
    QuizQuestion(
      'Which movie features a character named Hermione Granger?',
      [
        'Harry Potter and the Philosopher\'s Stone',
        'The Lord of the Rings',
        'The Hunger Games',
        'Twilight'
      ],
    ),
    QuizQuestion(
      'Who directed the movie "The Godfather"?',
      [
        'Francis Ford Coppola',
        'Martin Scorsese',
        'Steven Spielberg',
        'Alfred Hitchcock'
      ],
    ),
    QuizQuestion(
      'Which TV series features a character named Walter White?',
      [
        'Breaking Bad',
        'Stranger Things',
        'Game of Thrones',
        'The Walking Dead'
      ],
    ),
  ],
  [
    QuizQuestion(
      'Who played the character of Forrest Gump in the movie "Forrest Gump"?',
      ['Tom Hanks', 'Brad Pitt', 'Leonardo DiCaprio', 'Johnny Depp'],
    ),
    QuizQuestion(
      'Which movie features a character named Darth Vader?',
      ['Star Wars', 'The Lord of the Rings', 'Avatar', 'The Matrix'],
    ),
    QuizQuestion(
      'Who directed the movie "The Dark Knight"?',
      [
        'Christopher Nolan',
        'Martin Scorsese',
        'Steven Spielberg',
        'Quentin Tarantino'
      ],
    ),
    QuizQuestion(
      'Which TV series is set in the fictional town of Pawnee?',
      ['Parks and Recreation', 'The Office', 'Brooklyn Nine-Nine', 'New Girl'],
    ),
    QuizQuestion(
      'Who portrayed the character of Tony Montana in the movie "Scarface"?',
      ['Al Pacino', 'Robert De Niro', 'Marlon Brando', 'Joe Pesci'],
    ),
  ],
  [
    QuizQuestion(
      'Which movie won the Academy Award for Best Picture in 2019?',
      ['Parasite', 'Green Book', 'Moonlight', 'The Shape of Water'],
    ),
    QuizQuestion(
      'Which TV series is set in the fictional town of Twin Peaks?',
      ['Twin Peaks', 'Stranger Things', 'The X-Files', 'Breaking Bad'],
    ),
    QuizQuestion(
      'Who played the role of Indiana Jones in the movie series?',
      ['Harrison Ford', 'Tom Cruise', 'Brad Pitt', 'Leonardo DiCaprio'],
    ),
    QuizQuestion(
      'Which movie features a character named Ellen Ripley?',
      ['Alien', 'The Terminator', 'Blade Runner', 'Predator'],
    ),
    QuizQuestion(
      'Who directed the movie "Schindler\'s List"?',
      [
        'Steven Spielberg',
        'Francis Ford Coppola',
        'Martin Scorsese',
        'Quentin Tarantino'
      ],
    ),
  ],
];

final movieAndTVAnswers = [
  [
    'Harry Potter and the Philosopher\'s Stone',
    'Robert Downey Jr.',
    'Game of Thrones',
    'Christopher Nolan',
    'Leonardo DiCaprio',
  ],
  [
    'Parasite',
    'Stranger Things',
    'Jennifer Lawrence',
    'The Lord of the Rings',
    'Frank Darabont',
  ],
  [
    'The Simpsons',
    'Keanu Reeves',
    'Harry Potter and the Philosopher\'s Stone',
    'Francis Ford Coppola',
    'Breaking Bad',
  ],
  [
    'Tom Hanks',
    'Star Wars',
    'Christopher Nolan',
    'Parks and Recreation',
    'Al Pacino',
  ],
  [
    'Moonlight',
    'Twin Peaks',
    'Harrison Ford',
    'Alien',
    'Steven Spielberg',
  ],
];

const foodAndCuisineQuestions =  [
  [
    QuizQuestion(
      'What is the main ingredient in a classic Caprese salad?',
      ['Tomatoes', 'Mozzarella', 'Basil', 'Olive Oil'],
    ),
    QuizQuestion(
      'Which cuisine is known for its use of kimchi?',
      ['Korean', 'Japanese', 'Chinese', 'Thai'],
    ),
    QuizQuestion(
      'What is the primary ingredient in guacamole?',
      ['Avocado', 'Tomato', 'Onion', 'Lime'],
    ),
    QuizQuestion(
      'What type of pastry is used to make a croissant?',
      ['Puff Pastry', 'Shortcrust Pastry', 'Choux Pastry', 'Filo Pastry'],
    ),
    QuizQuestion(
      'What is the main ingredient in hummus?',
      ['Chickpeas', 'Lentils', 'Black Beans', 'Kidney Beans'],
    ),
  ],
  [
    QuizQuestion(
      'Which country is famous for its Neapolitan pizza?',
      ['Italy', 'France', 'Spain', 'Greece'],
    ),
    QuizQuestion(
      'What is the primary ingredient in sushi?',
      ['Rice', 'Fish', 'Seaweed', 'Soy Sauce'],
    ),
    QuizQuestion(
      'Which spice is derived from the Crocus sativus flower?',
      ['Saffron', 'Turmeric', 'Cumin', 'Paprika'],
    ),
    QuizQuestion(
      'What is the traditional base ingredient in pesto sauce?',
      ['Basil', 'Parsley', 'Spinach', 'Arugula'],
    ),
    QuizQuestion(
      'What type of pasta is shaped like small rice grains?',
      ['Orzo', 'Farfalle', 'Penne', 'Rotini'],
    ),
  ],
  [
    QuizQuestion(
      'What is the primary ingredient in a classic Margherita pizza?',
      ['Tomato Sauce', 'Mozzarella Cheese', 'Basil', 'Olive Oil'],
    ),
    QuizQuestion(
      'Which fruit is used to make a classic Tarte Tatin?',
      ['Apple', 'Pear', 'Peach', 'Plum'],
    ),
    QuizQuestion(
      'What type of meat is used in a traditional Beef Wellington?',
      ['Beef Fillet', 'Chicken Breast', 'Pork Tenderloin', 'Lamb Shank'],
    ),
    QuizQuestion(
      'Which country is famous for its paella?',
      ['Spain', 'Italy', 'Greece', 'France'],
    ),
    QuizQuestion(
      'What is the main ingredient in traditional Greek moussaka?',
      ['Eggplant', 'Zucchini', 'Tomato', 'Potato'],
    ),
  ],
  [
    QuizQuestion(
      'What is the primary ingredient in a classic Caesar salad?',
      ['Romaine Lettuce', 'Chicken', 'Croutons', 'Parmesan Cheese'],
    ),
    QuizQuestion(
      'Which country is famous for its Goulash dish?',
      ['Hungary', 'Germany', 'Austria', 'Poland'],
    ),
    QuizQuestion(
      'What type of cheese is traditionally used in a French Croque Monsieur sandwich?',
      ['Gruyère', 'Cheddar', 'Brie', 'Swiss'],
    ),
    QuizQuestion(
      'Which nut is a key ingredient in traditional pesto sauce?',
      ['Pine Nut', 'Almond', 'Walnut', 'Cashew'],
    ),
    QuizQuestion(
      'What is the primary ingredient in traditional Mexican guacamole?',
      ['Avocado', 'Tomato', 'Onion', 'Lime'],
    ),
  ],
  [
    QuizQuestion(
      'Which country is famous for its butter chicken dish?',
      ['India', 'Thailand', 'Vietnam', 'Malaysia'],
    ),
    QuizQuestion(
      'What is the primary ingredient in traditional French onion soup?',
      ['Onions', 'Beef Broth', 'Cheese', 'Bread'],
    ),
    QuizQuestion(
      'Which type of fish is used in traditional fish and chips?',
      ['Cod', 'Salmon', 'Haddock', 'Trout'],
    ),
    QuizQuestion(
      'What is the main ingredient in traditional Spanish gazpacho?',
      ['Tomatoes', 'Cucumbers', 'Peppers', 'Onions'],
    ),
    QuizQuestion(
      'Which type of bread is typically used in a classic BLT sandwich?',
      ['White Bread', 'Sourdough Bread', 'Whole Wheat Bread', 'Rye Bread'],
    ),
  ],
];

final foodAndCuisineAnswers = [
  ['Mozzarella', 'Korean', 'Avocado', 'Puff Pastry', 'Chickpeas'],
  ['Italy', 'Fish', 'Saffron', 'Basil', 'Japan'],
  ['Italy', 'Apple', 'Beef Fillet', 'Spain', 'Eggplant'],
  ['Romaine Lettuce', 'Hungary', 'Gruyère', 'Pine Nut', 'Avocado'],
  ['India', 'Onions', 'Cod', 'Tomatoes', 'White Bread'],
];

const sportsquestions =  [
  [
    QuizQuestion(
      'Who is often referred to as "The King" in basketball?',
      ['LeBron James', 'Michael Jordan', 'Kobe Bryant', 'Shaquille O\'Neal'],
    ),
    QuizQuestion(
      'What is the maximum number of players a baseball team can have on the field at any given time?',
      ['9', '10', '11', '12'],
    ),
    QuizQuestion(
      'In which sport is the term "birdie" commonly used?',
      ['Golf', 'Tennis', 'Badminton', 'Table Tennis'],
    ),
    QuizQuestion(
      'Who holds the record for the most Olympic gold medals in track and field?',
      ['Usain Bolt', 'Carl Lewis', 'Jesse Owens', 'Michael Phelps'],
    ),
    QuizQuestion(
      'Which country won the FIFA World Cup in 2018?',
      ['France', 'Germany', 'Brazil', 'Argentina'],
    ),
  ],
  [
    QuizQuestion(
      'What is the distance between the pitcher\'s mound and home plate in baseball?',
      ['60 feet, 6 inches', '50 feet', '55 feet', '65 feet'],
    ),
    QuizQuestion(
      'In tennis, what is the term for zero points?',
      ['Love', 'Zero', 'Deuce', 'Ace'],
    ),
    QuizQuestion(
      'Who is the all-time leading scorer in the NBA?',
      ['Kareem Abdul-Jabbar', 'LeBron James', 'Kobe Bryant', 'Michael Jordan'],
    ),
    QuizQuestion(
      'What is the circumference of a standard basketball?',
      ['29.5 inches', '28.5 inches', '30 inches', '27 inches'],
    ),
    QuizQuestion(
      'Which country hosted the first modern Olympic Games in 1896?',
      ['Greece', 'France', 'USA', 'Germany'],
    ),
  ],
  [
    QuizQuestion(
      'In soccer, what is the penalty for a handball in the penalty area?',
      ['Penalty Kick', 'Yellow Card', 'Red Card', 'Throw-in'],
    ),
    QuizQuestion(
      'Who holds the record for the fastest 100-meter sprint in history?',
      ['Usain Bolt', 'Carl Lewis', 'Tyson Gay', 'Justin Gatlin'],
    ),
    QuizQuestion(
      'What is the highest possible score in a single frame of bowling?',
      ['300', '250', '350', '400'],
    ),
    QuizQuestion(
      'In golf, what is the term for scoring one stroke under par on a hole?',
      ['Birdie', 'Eagle', 'Bogey', 'Par'],
    ),
    QuizQuestion(
      'Who won the 2021 Super Bowl?',
      [
        'Tampa Bay Buccaneers',
        'Kansas City Chiefs',
        'Green Bay Packers',
        'New England Patriots'
      ],
    ),
  ],
  [
    QuizQuestion(
      'How many players are there on a rugby union team during a match?',
      ['15', '11', '13', '9'],
    ),
    QuizQuestion(
      'What is the standard length of an Olympic swimming pool in meters?',
      ['50 meters', '25 meters', '100 meters', '75 meters'],
    ),
    QuizQuestion(
      'Who holds the record for the most Grand Slam singles titles in tennis?',
      [
        'Margaret Court',
        'Serena Williams',
        'Steffi Graf',
        'Martina Navratilova'
      ],
    ),
    QuizQuestion(
      'In which sport is a shuttlecock used?',
      ['Badminton', 'Tennis', 'Table Tennis', 'Squash'],
    ),
    QuizQuestion(
      'What is the name of the trophy awarded to the winner of the NHL playoffs?',
      [
        'Stanley Cup',
        'President\'s Cup',
        'Vezina Trophy',
        'Hart Memorial Trophy'
      ],
    ),
  ],
  [
    QuizQuestion(
      'Who is the only boxer to hold world titles in eight different weight divisions?',
      ['Manny Pacquiao', 'Floyd Mayweather Jr.', 'Mike Tyson', 'Muhammad Ali'],
    ),
    QuizQuestion(
      'What is the standard weight of an Olympic men\'s shot put?',
      ['7.26 kilograms', '6 kilograms', '8 kilograms', '5 kilograms'],
    ),
    QuizQuestion(
      'Which country won the most gold medals in the 2016 Summer Olympics?',
      ['USA', 'China', 'Great Britain', 'Russia'],
    ),
    QuizQuestion(
      'In American football, what is the name of the play used to start each play from scrimmage?',
      ['Snap', 'Handoff', 'Pass', 'Kickoff'],
    ),
    QuizQuestion(
      'Who holds the record for the most home runs hit in a single MLB season?',
      ['Barry Bonds', 'Babe Ruth', 'Hank Aaron', 'Mark McGwire'],
    ),
  ]
];

final sportsAnswers = [
  ['LeBron James', '9', 'Golf', 'Carl Lewis', 'France'],
  ['60 feet, 6 inches', 'Love', 'Kareem Abdul-Jabbar', '29.5 inches', 'Greece'],
  ['Penalty Kick', 'Usain Bolt', '300', 'Birdie', 'Tampa Bay Buccaneers'],
  ['15', '50 meters', 'Margaret Court', 'Badminton', 'Stanley Cup'],
  ['Manny Pacquiao', '7.26 kilograms', 'USA', 'Snap', 'Barry Bonds']
];

const musicQuestions =  [
  [
    QuizQuestion(
      'Who is often referred to as the "King of Pop"?',
      ['Michael Jackson', 'Elvis Presley', 'Prince', 'Madonna'],
    ),
    QuizQuestion(
      'Which band performed the hit song "Bohemian Rhapsody"?',
      ['Queen', 'The Beatles', 'Led Zeppelin', 'Pink Floyd'],
    ),
    QuizQuestion(
      'Who is known for her album "21" and hit song "Rolling in the Deep"?',
      ['Adele', 'Taylor Swift', 'Beyoncé', 'Rihanna'],
    ),
    QuizQuestion(
      'Which artist released the album "Thriller" in 1982?',
      ['Michael Jackson', 'Prince', 'Madonna', 'Elton John'],
    ),
    QuizQuestion(
      'What is the name of Beyoncé\'s fanbase?',
      ['Beyhive', 'Swifties', 'Barbz', 'Rih Navy'],
    ),
  ],
  [
    QuizQuestion(
      'Who is known as the "Queen of Soul"?',
      ['Aretha Franklin', 'Whitney Houston', 'Tina Turner', 'Diana Ross'],
    ),
    QuizQuestion(
      'What was the first music video aired on MTV?',
      [
        'Video Killed the Radio Star',
        'Thriller',
        'Billie Jean',
        'Bohemian Rhapsody'
      ],
    ),
    QuizQuestion(
      'Who was the lead singer of the band Nirvana?',
      ['Kurt Cobain', 'Eddie Vedder', 'Chris Cornell', 'Dave Grohl'],
    ),
    QuizQuestion(
      'What is the best-selling album of all time?',
      ['Thriller', 'Back in Black', 'The Dark Side of the Moon', 'Abbey Road'],
    ),
    QuizQuestion(
      'Who won the first season of American Idol?',
      ['Kelly Clarkson', 'Carrie Underwood', 'Adam Lambert', 'Jennifer Hudson'],
    ),
  ],
  [
    QuizQuestion(
      'Which artist released the album "Lemonade" in 2016?',
      ['Beyoncé', 'Rihanna', 'Taylor Swift', 'Adele'],
    ),
    QuizQuestion(
      'Who wrote the song "Like a Rolling Stone"?',
      ['Bob Dylan', 'The Beatles', 'Elvis Presley', 'David Bowie'],
    ),
    QuizQuestion(
      'Which artist is known for the hit song "Hey Jude"?',
      ['The Beatles', 'Elton John', 'Bob Dylan', 'David Bowie'],
    ),
    QuizQuestion(
      'What is the name of Taylor Swift\'s first album?',
      ['Taylor Swift', 'Fearless', 'Speak Now', 'Red'],
    ),
    QuizQuestion(
      'Which artist released the album "The Wall"?',
      ['Pink Floyd', 'Led Zeppelin', 'Queen', 'The Rolling Stones'],
    ),
  ],
  [
    QuizQuestion(
      'Who won the most Grammy Awards in a single night?',
      ['Beyoncé', 'Michael Jackson', 'Adele', 'Taylor Swift'],
    ),
    QuizQuestion(
      'What is the real name of rapper Eminem?',
      ['Marshall Mathers', 'Curtis Jackson', 'Shawn Carter', 'Calvin Broadus'],
    ),
    QuizQuestion(
      'Who is known as the "King of Rock and Roll"?',
      ['Elvis Presley', 'Chuck Berry', 'Buddy Holly', 'Jerry Lee Lewis'],
    ),
    QuizQuestion(
      'What is Madonna\'s full birth name?',
      [
        'Madonna Louise Ciccone',
        'Madonna Maria Francesca',
        'Madonna Louise Veronica',
        'Madonna Angela Maria'
      ],
    ),
    QuizQuestion(
      'Which artist performed the song "Purple Rain"?',
      ['Prince', 'Michael Jackson', 'David Bowie', 'Elton John'],
    ),
  ],
  [
    QuizQuestion(
      'Who is the lead vocalist of the band Queen?',
      ['Freddie Mercury', 'John Lennon', 'Mick Jagger', 'Bono'],
    ),
    QuizQuestion(
      'Which artist released the album "Back to Black"?',
      ['Amy Winehouse', 'Adele', 'Beyoncé', 'Rihanna'],
    ),
    QuizQuestion(
      'What is the real name of rapper Jay-Z?',
      ['Shawn Carter', 'Marshall Mathers', 'Curtis Jackson', 'Calvin Broadus'],
    ),
    QuizQuestion(
      'Who wrote and originally recorded the song "Respect"?',
      ['Otis Redding', 'Aretha Franklin', 'Etta James', 'Tina Turner'],
    ),
    QuizQuestion(
      'What is the name of the Beatles\' final studio album?',
      [
        'Let It Be',
        'Abbey Road',
        'The White Album',
        'Sgt. Pepper\'s Lonely Hearts Club Band'
      ],
    ),
  ]
];

final musicAnswers = [
  ['Michael Jackson', 'Queen', 'Adele', 'Michael Jackson', 'Beyhive'],
  [
    'Aretha Franklin',
    'Video Killed the Radio Star',
    'Kurt Cobain',
    'Thriller',
    'Kelly Clarkson'
  ],
  ['Beyoncé', 'Bob Dylan', 'The Beatles', 'Taylor Swift', 'Pink Floyd'],
  [
    'Beyoncé',
    'Marshall Mathers',
    'Elvis Presley',
    'Madonna Louise Ciccone',
    'Prince'
  ],
  [
    'Freddie Mercury',
    'Amy Winehouse',
    'Shawn Carter',
    'Otis Redding',
    'Let It Be'
  ],
];

const scienceTechQuestions =  [
  [
    QuizQuestion(
      'What is the closest planet to the Sun?',
      ['Mercury', 'Venus', 'Earth', 'Mars'],
    ),
    QuizQuestion(
      'Which scientist is credited with the theory of general relativity?',
      ['Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Stephen Hawking'],
    ),
    QuizQuestion(
      'What is the largest mammal on Earth?',
      ['Blue Whale', 'African Elephant', 'Giraffe', 'Hippopotamus'],
    ),
    QuizQuestion(
      'What is the chemical symbol for gold?',
      ['Au', 'Ag', 'Cu', 'Fe'],
    ),
    QuizQuestion(
      'What is the hardest natural substance on Earth?',
      ['Diamond', 'Steel', 'Graphite', 'Iron'],
    ),
  ],
  [
    QuizQuestion(
      'Which planet is known as the "Red Planet"?',
      ['Mars', 'Venus', 'Jupiter', 'Saturn'],
    ),
    QuizQuestion(
      'Who is known as the "Father of Modern Chemistry"?',
      ['Antoine Lavoisier', 'John Dalton', 'Dmitri Mendeleev', 'Marie Curie'],
    ),
    QuizQuestion(
      'What is the powerhouse of the cell?',
      ['Mitochondrion', 'Nucleus', 'Endoplasmic Reticulum', 'Golgi Apparatus'],
    ),
    QuizQuestion(
      'What is the chemical formula for water?',
      ['H2O', 'CO2', 'O2', 'NaCl'],
    ),
    QuizQuestion(
      'What is the smallest bone in the human body?',
      ['Stapes', 'Femur', 'Tibia', 'Radius'],
    ),
  ],
  [
    QuizQuestion(
      'What is the process by which plants make their food?',
      ['Photosynthesis', 'Respiration', 'Transpiration', 'Pollination'],
    ),
    QuizQuestion(
      'Which planet is the largest in our solar system?',
      ['Jupiter', 'Saturn', 'Uranus', 'Neptune'],
    ),
    QuizQuestion(
      'What is the study of fossils called?',
      ['Paleontology', 'Archaeology', 'Geology', 'Anthropology'],
    ),
    QuizQuestion(
      'What is the chemical symbol for iron?',
      ['Fe', 'Au', 'Ag', 'Cu'],
    ),
    QuizQuestion(
      'What is the process by which plants release water vapor into the air?',
      ['Transpiration', 'Condensation', 'Evaporation', 'Precipitation'],
    ),
  ],
  [
    QuizQuestion(
      'What is the Earth\'s primary source of energy?',
      ['Sun', 'Moon', 'Stars', 'Lightning'],
    ),
    QuizQuestion(
      'Which scientist is known for the theory of evolution by natural selection?',
      ['Charles Darwin', 'Gregor Mendel', 'Louis Pasteur', 'Alfred Wegener'],
    ),
    QuizQuestion(
      'What is the chemical formula for table salt?',
      ['NaCl', 'H2O', 'CO2', 'O2'],
    ),
    QuizQuestion(
      'What is the largest organ in the human body?',
      ['Skin', 'Liver', 'Heart', 'Brain'],
    ),
    QuizQuestion(
      'What is the process by which rocks are broken down into smaller particles?',
      ['Weathering', 'Erosion', 'Deposition', 'Compaction'],
    ),
  ],
  [
    QuizQuestion(
      'What is the study of earthquakes called?',
      ['Seismology', 'Meteorology', 'Geology', 'Volcanology'],
    ),
    QuizQuestion(
      'Which gas do plants absorb during photosynthesis?',
      ['Carbon Dioxide', 'Oxygen', 'Nitrogen', 'Hydrogen'],
    ),
    QuizQuestion(
      'What is the largest internal organ in the human body?',
      ['Liver', 'Heart', 'Lung', 'Kidney'],
    ),
    QuizQuestion(
      'What is the chemical formula for hydrogen peroxide?',
      ['H2O2', 'CO2', 'O2', 'NaCl'],
    ),
    QuizQuestion(
      'What is the process by which plants respond to light?',
      ['Phototropism', 'Geotropism', 'Hydrotropism', 'Thigmotropism'],
    ),
  ],
];

final scienceTechAnswers = [
  ['Mercury', 'Albert Einstein', 'Blue Whale', 'Au', 'Diamond'],
  ['Mars', 'Antoine Lavoisier', 'Mitochondrion', 'H2O', 'Stapes'],
  ['Photosynthesis', 'Jupiter', 'Paleontology', 'Fe', 'Transpiration'],
  ['Sun', 'Charles Darwin', 'NaCl', 'Skin', 'Weathering'],
  ['Seismology', 'Carbon Dioxide', 'Liver', 'H2O2', 'Phototropism'],
];
