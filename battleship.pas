program Battleship;

const
  SIZE = 5;
  SHIP = 'S';
  WATER = '~';
  HIT = 'X';
  MISS = 'O';

type
  TBoard = array[1..SIZE, 1..SIZE] of char;

var
  playerBoard, enemyBoard: TBoard;
  x, y: integer;

procedure InitializeBoard(var board: TBoard);
var
  i, j: integer;
begin
  for i := 1 to SIZE do
    for j := 1 to SIZE do
      board[i, j] := WATER;
end;

procedure PlaceShips(var board: TBoard);
var
  i: integer;
begin
  for i := 1 to 3 do
  begin
    board[random(SIZE) + 1, random(SIZE) + 1] := SHIP;
  end;
end;

procedure PrintBoard(board: TBoard);
var
  i, j: integer;
begin
  for i := 1 to SIZE do
  begin
    for j := 1 to SIZE do
      write(board[i, j], ' ');
    writeln;
  end;
end;

function FireAt(board: TBoard; x, y: integer): boolean;
begin
  if board[x, y] = SHIP then
  begin
    writeln('Hit!');
    FireAt := true;
  end
  else
  begin
    writeln('Miss!');
    FireAt := false;
  end;
end;

procedure UpdateBoard(var board: TBoard; x, y: integer; hit: boolean);
begin
  if hit then
    board[x, y] := HIT
  else
    board[x, y] := MISS;
end;

begin
  randomize;
  InitializeBoard(playerBoard);
  InitializeBoard(enemyBoard);
  
  PlaceShips(enemyBoard);
  
  repeat
    PrintBoard(playerBoard);
    writeln('Enter coordinates to fire (x y): ');
    readln(x, y);
    
    if FireAt(enemyBoard, x, y) then
      UpdateBoard(playerBoard, x, y, true)
    else
      UpdateBoard(playerBoard, x, y, false);
  until false;
end.
