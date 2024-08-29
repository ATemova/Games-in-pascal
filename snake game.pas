program SnakeGame;

uses Crt;

const
  WIDTH = 20;
  HEIGHT = 20;
  EMPTY = ' ';
  FOOD = '*';
  SNAKE = '#';

type
  TPosition = record
    x, y: integer;
  end;

  TSnake = record
    body: array[1..100] of TPosition;
    length: integer;
  end;

var
  grid: array[1..WIDTH, 1..HEIGHT] of char;
  snake: TSnake;
  food: TPosition;
  direction: char;
  score: integer;

procedure InitializeGame;
var
  i, j: integer;
begin
  randomize;
  for i := 1 to WIDTH do
    for j := 1 to HEIGHT do
      grid[i, j] := EMPTY;

  snake.length := 1;
  snake.body[1].x := WIDTH div 2;
  snake.body[1].y := HEIGHT div 2;
  grid[snake.body[1].x, snake.body[1].y] := SNAKE;

  food.x := random(WIDTH) + 1;
  food.y := random(HEIGHT) + 1;
  grid[food.x, food.y] := FOOD;

  direction := 'r';
  score := 0;
end;

procedure PrintGrid;
var
  i, j: integer;
begin
  ClrScr;
  for i := 1 to WIDTH do
  begin
    for j := 1 to HEIGHT do
      write(grid[i, j], ' ');
    writeln;
  end;
  writeln('Score: ', score);
end;

procedure MoveSnake;
var
  i: integer;
  newHead: TPosition;
begin
  newHead := snake.body[1];

  case direction of
    'u': Dec(newHead.y);
    'd': Inc(newHead.y);
    'l': Dec(newHead.x);
    'r': Inc(newHead.x);
  end;

  if (newHead.x < 1) or (newHead.x > WIDTH) or (newHead.y < 1) or (newHead.y > HEIGHT) or (grid[newHead.x, newHead.y] = SNAKE) then
  begin
    writeln('Game Over!');
    writeln('Your final score: ', score);
    halt;
  end;

  if (newHead.x = food.x) and (newHead.y = food.y) then
  begin
    Inc(snake.length);
    Inc(score);
    food.x := random(WIDTH) + 1;
    food.y := random(HEIGHT) + 1;
    grid[food.x, food.y] := FOOD;
  end;

  grid[snake.body[snake.length].x, snake.body[snake.length].y] := EMPTY;

  for i := snake.length downto 2 do
    snake.body[i] := snake.body[i-1];

  snake.body[1] := newHead;
  grid[snake.body[1].x, snake.body[1].y] := SNAKE;
end;

procedure GetDirection;
begin
  if KeyPressed then
  begin
    case ReadKey of
      'w': direction := 'u';
      's': direction := 'd';
      'a': direction := 'l';
      'd': direction := 'r';
    end;
  end;
end;

begin
  InitializeGame;
  repeat
    PrintGrid;
    GetDirection;
    MoveSnake;
    Delay(200);
  until false;
end.
