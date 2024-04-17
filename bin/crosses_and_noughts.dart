import 'dart:io';

void main() {
  var gameField = List<List<Square>>.generate(
      3, (i) => List<Square>.generate(3, (j) => Square(Figures.empty)));
  var currentPlayer = Players.first;
  drawField(gameField);

  do {
    currentPlayer = turn(currentPlayer, gameField);
    drawField(gameField);
  } while (isWon(gameField) || isDraw(gameField));

  if (isWon(gameField)) {
    print('Игрок $currentPlayer победил');
  } else {
    print('Ничья');
  }
}

Players turn(var currentPlayer, List<List<Square>> field) {
  print('Ходит $currentPlayer игрок.');
  print('Введите координаты квадрата: ');
  var inputCoords = stdin.readLineSync();

  var x = int.parse(inputCoords![0]);
  var y = int.parse(inputCoords[2]);
  (currentPlayer == Players.first)
      ? field[x][y].content = Figures.cross
      : field[x][y].content = Figures.nought;
  (currentPlayer == Players.first)
      ? currentPlayer = Players.second
      : currentPlayer = Players.first;

  return currentPlayer;
}

//чета исправил
//bool checkInput(String input){
//    while (input == null){
//        print('Введите координаты квадрата: ');
//        var input = stdin.readLineSync();
//    }
//}

void drawField(List<List<Square>> field) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      stdout.write('${field[i][j].content.mark}|');
    }
    print('');
  }
}

bool isWon(List<List<Square>> field) {
  if ((field[0][0].content == field[0][1].content) &&
      (field[0][0].content == field[0][2].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }
  ;

  if ((field[0][0].content == field[1][0].content) &&
      (field[0][0].content == field[2][0].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }
  ;

  if ((field[1][0].content == field[1][1].content) &&
      (field[1][0].content == field[1][2].content) &&
      (field[1][0].content != Figures.empty)) {
    return true;
  }
  ;

  if ((field[2][0].content == field[2][1].content) &&
      (field[2][0].content == field[2][2].content) &&
      (field[2][0].content != Figures.empty)) {
    return true;
  }
  ;

  if ((field[0][0].content == field[1][1].content) &&
      (field[0][0].content == field[2][2].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }
  ;

  if ((field[2][0].content == field[1][1].content) &&
      (field[2][0].content == field[0][2].content) &&
      (field[2][0].content != Figures.empty)) {
    return true;
  }
  ;

  return false;
}

bool isDraw(List<List<Square>> field) {
  if (field.contains(Figures.empty)) {
    return false;
  } else {
    return true;
  }
}

enum Figures {
  cross('✖'),
  nought('〇'),
  empty('_');

  const Figures(this.mark);
  final String mark;
}

enum Players { first, second }

class Square {
  Figures content;

  Square(this.content);
}
