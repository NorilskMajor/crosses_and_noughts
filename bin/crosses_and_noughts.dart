import 'dart:io';

void main() {
  var gameField = List<List<Square>>.generate(
      3, (i) => List<Square>.generate(3, (j) => Square(Figures.empty)));
  var currentPlayer = Players.first;
  drawField(gameField);

  do {
    turn(currentPlayer, gameField);
    currentPlayer = playerChange(currentPlayer);
  } while (!isWon(gameField) || !isDraw(gameField));

  if (isWon(gameField)) {
    currentPlayer = playerChange(currentPlayer);
    print('Игрок $currentPlayer победил');
  } else {
    print('Ничья');
  }
}

//Метод playerChange меняет игрока
Players playerChange(Players currentPlayer){
  (currentPlayer == Players.first)
      ? currentPlayer = Players.second
      : currentPlayer = Players.first;
  return currentPlayer;
}


//Метод turn добавляет крестик или нолик и отрисовывает игровое поле
void turn(var currentPlayer, List<List<Square>> field) {
  print('Ходит $currentPlayer игрок.');
  print('Введите координаты квадрата по горизонтали: ');
  var x = int.parse(stdin.readLineSync() ?? '0');
  print('Введите координаты квадрата по вертикали: ');
  var y = int.parse(stdin.readLineSync() ?? '0');


  //var inputCoords = stdin.readLineSync() ?? '0';

  //var x = int.parse(inputCoords[0]);
  //var y = int.parse(inputCoords[2]);




  (currentPlayer == Players.first)
      ? field[x][y].content = Figures.cross
      : field[x][y].content = Figures.nought;
  drawField(field);
  
}

//bool checkInput(String input){
//    while (input == null){
//        print('Введите координаты квадрата: ');
//        var input = stdin.readLineSync();
//    }
//}


//Метод drawField отрисовывает игровое поле
void drawField(List<List<Square>> field) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      stdout.write('${field[i][j].content.mark}|');
    }
    print('');
  }
}

//Метод isWon проверяет условия победы
bool isWon(List<List<Square>> field) {
  if ((field[0][0].content == field[0][1].content) &&
      (field[0][0].content == field[0][2].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }


  if ((field[0][0].content == field[1][0].content) &&
      (field[0][0].content == field[2][0].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }
 

  if ((field[1][0].content == field[1][1].content) &&
      (field[1][0].content == field[1][2].content) &&
      (field[1][0].content != Figures.empty)) {
    return true;
  }
 

  if ((field[2][0].content == field[2][1].content) &&
      (field[2][0].content == field[2][2].content) &&
      (field[2][0].content != Figures.empty)) {
    return true;
  }
  

  if ((field[0][0].content == field[1][1].content) &&
      (field[0][0].content == field[2][2].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }
  

  if ((field[2][0].content == field[1][1].content) &&
      (field[2][0].content == field[0][2].content) &&
      (field[2][0].content != Figures.empty)) {
    return true;
  }
  

  return false;
}


//Метод isDraw проверяет условия ничьи
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
