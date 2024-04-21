import 'dart:io';

void main() {
  var gameField = List<List<Square>>.generate(
      3, (i) => List<Square>.generate(3, (j) => Square(Figures.empty)));
  var currentPlayer = Players.first;
  drawField(gameField);

  do {
    turn(currentPlayer, gameField);
    currentPlayer = playerChange(currentPlayer);
  } while (!isWon(gameField) && !isDraw(gameField));

  if (isWon(gameField)) {
    currentPlayer = playerChange(currentPlayer);
    print('Игрок ${currentPlayer.ruLocalization} победил');
  } else {
    print('Ничья');
  }
}

//Метод playerChange меняет игрока
Players playerChange(Players currentPlayer) {
  (currentPlayer == Players.first)
      ? currentPlayer = Players.second
      : currentPlayer = Players.first;
  return currentPlayer;
}

//Метод turn добавляет крестик или нолик и отрисовывает игровое поле
void turn(var currentPlayer, List<List<Square>> field) {
  print('Ходит ${currentPlayer.ruLocalization} игрок.');
  print('Введите координаты квадрата по горизонтали: ');
  var x = int.parse(stdin.readLineSync() ?? '0');
  print('Введите координаты квадрата по вертикали: ');
  var y = int.parse(stdin.readLineSync() ?? '0');

  (currentPlayer == Players.first)
      ? field[x][y].content = Figures.cross
      : field[x][y].content = Figures.nought;
  drawField(field);
}

bool isCorrect(int x, int y, List<List<Square>> field) {
  if (field[x][y].content != Figures.empty) {
    print('Клетка занята');
    return false;
  }
  return true;
}


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
//Верхняя строка
  if ((field[0][0].content == field[0][1].content) &&
      (field[0][0].content == field[0][2].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }

//Левый столбец
  if ((field[0][0].content == field[1][0].content) &&
      (field[0][0].content == field[2][0].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }

//Средняя строка
  if ((field[1][0].content == field[1][1].content) &&
      (field[1][0].content == field[1][2].content) &&
      (field[1][0].content != Figures.empty)) {
    return true;
  }

//Нижняя строка
  if ((field[2][0].content == field[2][1].content) &&
      (field[2][0].content == field[2][2].content) &&
      (field[2][0].content != Figures.empty)) {
    return true;
  }

//Левая горизонталь
  if ((field[0][0].content == field[1][1].content) &&
      (field[0][0].content == field[2][2].content) &&
      (field[0][0].content != Figures.empty)) {
    return true;
  }

//Правая горизонталь
  if ((field[2][0].content == field[1][1].content) &&
      (field[2][0].content == field[0][2].content) &&
      (field[2][0].content != Figures.empty)) {
    return true;
  }

//Средний столбец
  if ((field[0][1].content == field[1][1].content) &&
      (field[0][1].content == field[2][1].content) &&
      (field[0][1].content != Figures.empty)) {
    return true;
  }

//Правый столбец
  if ((field[0][2].content == field[1][2].content) &&
      (field[0][2].content == field[2][2].content) &&
      (field[0][2].content != Figures.empty)) {
    return true;
  }

  return false;
}

//Метод isDraw проверяет условия ничьи
bool isDraw(List<List<Square>> field) {
  for (int i = 0; i < field.length; i++) {
    for (int j = 0; j < field.length; j++) {
      if (field[i][j].content == Figures.empty) {
        return false;
      }
    }
  }
  return true;
}

enum Figures {
  cross('❌'),
  nought('〇'),
  empty('＿');

  const Figures(this.mark);
  final String mark;
}

enum Players {
  first('первый'),
  second('второй');

  const Players(this.ruLocalization);
  final String ruLocalization;
}

class Square {
  Figures content;

  Square(this.content);
}
