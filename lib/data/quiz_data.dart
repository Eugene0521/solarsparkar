import '../models/quiz.dart';

final List<Quiz> quizzes = [
  Quiz(
    title: "Solar System Quiz (3rd Grade)",
    description: "Test your knowledge about the Solar System!",
    questions: [
      Question(
        question: "How many planets are there in our solar system?",
        options: ["a) Eight", "b) Nine"],
        correctAnswerIndex: 0, // Points to "a) Eight"
      ),
      Question(
        question: "Is the Sun a planet?",
        options: ["a) Yes", "b) No"],
        correctAnswerIndex: 1, // Points to "b) No"
      ),
      Question(
        question: "Which is the smallest planet?",
        options: ["a) Mercury", "b) Jupiter"],
        correctAnswerIndex: 0, // Points to "a) Mercury"
      ),
      Question(
        question: "Is Venus hotter than Mercury?",
        options: ["a) Yes", "b) No"],
        correctAnswerIndex: 0, // Points to "a) Yes"
      ),
      Question(
        question: "Which are the coldest planets?",
        options: [
          "a) Saturn, Uranus, and Neptune",
          "b) Mercury, Venus, and Earth"
        ],
        correctAnswerIndex: 0, // Points to "a) Saturn, Uranus, and Neptune"
      ),
      Question(
        question: "Which is the biggest planet?",
        options: ["a) Saturn", "b) Jupiter"],
        correctAnswerIndex: 1, // Points to "b) Jupiter"
      ),
      Question(
        question: "Which is the farthest planet from the Sun?",
        options: ["a) Neptune", "b) Uranus"],
        correctAnswerIndex: 0, // Points to "a) Neptune"
      ),
      Question(
        question: "Which is the hottest planet?",
        options: ["a) Mercury", "b) Venus"],
        correctAnswerIndex: 1, // Points to "b) Venus"
      ),
      Question(
        question: "We live on this planet.",
        options: ["a) Earth", "b) Mars"],
        correctAnswerIndex: 0, // Points to "a) Earth"
      ),
      Question(
        question: "It's the red planet.",
        options: ["a) Mars", "b) Uranus"],
        correctAnswerIndex: 0, // Points to "a) Mars"
      ),
    ],
  ),

  Quiz(
    title: "Solar System Quiz (4th Grade)",
    description: "Test your knowledge about Solar System!",
    questions: [
      Question(
        question: "The Earth orbits around the Sun.",
        options: ["a) False", "b) True"],
        correctAnswerIndex: 1, // Points to "b) True"
      ),
      Question(
        question: "Which is the largest object in our solar system?",
        options: ["a) Sun", "b) Jupiter", "c) Earth", "d) Pluto"],
        correctAnswerIndex: 0, // Points to "a) Sun"
      ),
      Question(
        question: "How many planets are there in our Solar System?",
        options: ["a) 7", "b) 8", "c) 9", "d) 10"],
        correctAnswerIndex: 1, // Points to "b) 8"
      ),
      Question(
        question: "Which is smaller: Earth or Moon?",
        options: ["a) Earth", "b) Moon"],
        correctAnswerIndex: 1, // Points to "b) Moon"
      ),
      Question(
        question: "The fourth planet from the Sun; also known as the red planet.",
        options: ["a) Neptune", "b) Mercury", "c) Earth", "d) Mars"],
        correctAnswerIndex: 3, // Points to "d) Mars"
      ),
      Question(
        question: "Which planet is closest to the sun?",
        options: ["a) Uranus", "b) Mercury", "c) Neptune", "d) Earth"],
        correctAnswerIndex: 1, // Points to "b) Mercury"
      ),
      Question(
        question: "What is the largest planet in our solar system?",
        options: ["a) Earth", "b) Saturn", "c) Jupiter", "d) The Sun"],
        correctAnswerIndex: 2, // Points to "c) Jupiter"
      ),
      Question(
        question: "This is the phase of the moon when the moon looks like a thin sliver (less than half of the moon's nearside is sunlit).",
        options: ["a) Crescent", "b) Gibbous", "c) full", "d) New"],
        correctAnswerIndex: 0, // Points to "a) Crescent"
      ),
      Question(
        question: "A group of stars that make a pattern in the night sky.",
        options: ["a) Planets", "b) Comets", "c) Asteroids", "d) Constellation"],
        correctAnswerIndex: 3, // Points to "d) Constellation"
      ),
      Question(
        question: "Stars DO NOT twinkle in the sky; only planets twinkle in the sky.",
        options: ["a) True", "b) False"],
        correctAnswerIndex: 1, // Points to "b) False"
      ),
      Question(
        question: "This is the eighth (last) planet from the Sun; it is deep dark blue in color.",
        options: ["a) Earth", "b) Neptune", "c) Mercury", "d) Mercury"],
        correctAnswerIndex: 1, // Points to "b) Neptune"
      ),
      Question(
        question: "This is the first planet from the Sun; it is very hot in the day and very cold in the night.",
        options: ["a) Mercury", "b) Neptune", "c) Earth", "d) Jupiter"],
        correctAnswerIndex: 0, // Points to "a) Mercury"
      ),
      Question(
        question: "Which planet is the brightest planet?",
        options: ["a) Mars", "b) Saturn", "c) Venus", "d) Jupiter"],
        correctAnswerIndex: 2, // Points to "c) Venus"
      ),
      Question(
        question: "Which planet has the largest rings",
        options: ["a) Jupiter", "b) Venus", "c) Mercury", "d) Saturn"],
        correctAnswerIndex: 3, // Points to "d) Saturn"
      ),
    ],
  ),

  Quiz(
    title: "Solar System Quiz (6th Grade)",
    description: "How well do you know the Solar System?",
    questions: [
      Question(
        question: "What is the center of the solar system?",
        options: ["a) Sun", "b) Moon", "c) Earth", "d) Mars"],
        correctAnswerIndex: 0, // Points to "a) Sun"
      ),
      Question(
        question: "How many planets in our solar system?",
        options: ["a) 10", "b) 8", "c) 9", "d) 5"],
        correctAnswerIndex: 1, // Points to "b) 8"
      ),
      Question(
        question: "What planet is closest to the sun?",
        options: ["a) Mars", "b) Earth", "c) Mercury", "d) Venus"],
        correctAnswerIndex: 2, // Points to "c) Mercury"
      ),
      Question(
        question: "What planet are called the ring planet?",
        options: ["a) Jupiter", "b) Uranus", "c) Neptune", "d) Saturn"],
        correctAnswerIndex: 3, // Points to "d) Saturn"
      ),
      Question(
        question: "What is the biggest planet in solar system?",
        options: ["a) Jupiter", "b) Uranus", "c) Neptune", "d) Saturn"],
        correctAnswerIndex: 0, // Points to "a) Jupiter"
      ),
      Question(
        question: "Which of the following is a natural source of heat energy?",
        options: ["a) Sun", "b) Flash light", "c) Laser", "d) Stove"],
        correctAnswerIndex: 0, // Points to "a) Sun"
      ),
      Question(
        question: "It is the transfer of heat to a solid object.",
        options: ["a) Conduction", "b) Convection", "c) Radiation", "d) Motion"],
        correctAnswerIndex: 0, // Points to "a) Conduction"
      ),
      Question(
        question: "Which is a good conductor of heat?",
        options: ["a) Glass", "b) Paper towel", "c) Metallic door", "d) Wooden handle"],
        correctAnswerIndex: 2, // Points to "c) Metallic"
      ),
      Question(
        question: "It is the process of transferring of heat, but the particles stay in one place.",
        options: ["a) Conduction", "b) Convection", "c) Radiation", "d) Motion"],
        correctAnswerIndex: 1, // Points to "b) Convection"
      ),
      Question(
        question: "It is light bounces off the surface",
        options: ["a) Reflection", "b) Refraction", "c) Transmission"],
        correctAnswerIndex: 0, // Points to "a) Reflection"
      ),
    ],
  ),

  Quiz(
    title: "Solar Eclipse (5th - 6th Grade)",
    description: "Welcome to the 'Solar Eclipse' quiz! Test your knowledge about this fascinating celestial event. Let's see how much you know about the science, phenomena, and fun facts behind solar eclipses. Ready to shine? Let’s begin!",
    questions: [
      Question(
        question: "A solar eclipse occurs when:",
        options: [
          "a) The earth blocks sunlight from reaching the moon.", 
          "b) The moon blocks sunlight from reaching the earth.", 
          "c) The sun blocks sunlight from reaching the earth.", 
          "d) The sun doesn't come out during the day. "],
        correctAnswerIndex: 1, // Points to "b) The moon blocks sunlight from reaching the earth."
      ),
      Question(
        question: "How many planets in our solar system?",
        options: [
          "a) sun, earth, moon", 
          "b) earth, sun, moon", 
          "c) sun, moon, earth", 
          "d) moon, earth, sun"],
        correctAnswerIndex: 2, // Points to "c) sun, moon, earth"
      ),
      Question(
        question: "What is the darkest inner part of the shadow cone called, where a total eclipse can be viewed.",
        options: ["a) Total", "b) Umbra", "c) Penumbra"],
        correctAnswerIndex: 1, // Points to "b) Umbra"
      ),
      Question(
        question: "During a solar eclipse...",
        options: ["a) The sun is blocked", "b) The Earth is blocked"],
        correctAnswerIndex: 0, // Points to "The sun is blocked"
      ),
      Question(
        question: "You must wear your eclipse goggles at all times except during totality due to safety reasons.",
        options: ["a) True", "b) False"],
        correctAnswerIndex: 0, // Points to "a) True"
      ),
      Question(
        question: "Solar eclipses occur during which Moon phase?",
        options: ["a) New Moon", "b) Waning Crescent", "c) Waxing Crescent", "d) Waning Gibbous"],
        correctAnswerIndex: 0, // Points to "a) New Moon"
      ),
      Question(
        question: "You would see a partial solar eclipse if you were within the Moon’s penumbra.",
        options: ["a) True", "b) False"],
        correctAnswerIndex: 0, // Points to "a) True"
      ),
      Question(
        question: "What is the ring around the moon during solar eclipse called?",
        options: ["a) Cortana", "b) Corona", "c) Light ring", "d) Sun light"],
        correctAnswerIndex: 1, // Points to "b) Corona"
      ),
      Question(
        question: "In order to have an eclipse, the Moon, Sun and Earth have to be?",
        options: ["a) Below each other", "b) Above each other", "c) In alignment"],
        correctAnswerIndex: 2, // Points to "c) In alignment"
      ),
      Question(
        question: "During an eclipse of the Sun, animals behave strangely, crows start to sing and the atmosphere appears to be eerie.",
        options: ["a) True", "b) False"],
        correctAnswerIndex: 0, // Points to "a) True"
      ),
    ],
  ),
];
