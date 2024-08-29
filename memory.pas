program MemoryGame;

uses crt;

const
  SIZE = 4;

type
  TBoard = array[1..SIZE, 1..SIZE] of integer;
  TVisible = array[1..SIZE, 1..SIZE] of boolean;

var
  board: TBoard;
  visible: TVisible;
  x1, y1, x2, y2: integer;
  moves: integer;
  matches: integer;

procedure InitializeBoard(var b: TBoard);
var
  nums: array[1..SIZE * SIZE div 2] of integer;
  i, j, num: integer;
begin
  num := 1;
  for i := 1 to SIZE * SIZE div 2 do
    nums[i] := num;
    num := num + 1;
  
  for i := 1 to SIZE * SIZE div 2 do
    nums[i] := nums[random(SIZE * SIZE div 2) + 1];
  
  for i := 1 to SIZE do
    for j := 1 to SIZE do
      b[i, j] := nums[(i - 1) * SIZE div 2 + j];
end;

procedure PrintBoard(b: TBoard; v: TVisible);
var
  i, j: integer;
begin
  ClrScr;
  for i := 1 to SIZE do
  begin
    for j := 1 to SIZE do
    begin
      if v[i, j] then
        write(b[i, j]:4)
      else
        write('****':4);
    end;
    writeln;
  end;
end;

begin
  randomize;
  InitializeBoard(board);
  matches := 0;
  moves := 0;
  
  for i := 1 to SIZE do
    for j := 1 to SIZE do
      visible[i, j] := false;
  
  repeat
    PrintBoard(board, visible);
    
    writeln('Enter coordinates of first guess (row column): ');
    readln(x1, y1);
    
    if (x1 < 1) or (x1 > SIZE) or (y1 < 1) or (y1 > SIZE) then
    begin
      writeln('Invalid coordinates! Try again.');
      continue;
    end;
    
    visible[x1, y1] := true;
    PrintBoard(board, visible);
    
    writeln('Enter coordinates of second guess (row column): ');
    readln(x2, y2);
    
    if (x2 < 1) or (x2 > SIZE) or (y2 < 1) or (y2 > SIZE) then
    begin
      writeln('Invalid coordinates! Try again.');
      visible[x1, y1] := false;
      continue;
    end;
    
    visible[x2, y2] := true;
    PrintBoard(board, visible);
    
    if board[x1, y1] = board[x2, y2] then
    begin
      writeln('Match!');
      matches := matches + 1;
    end
    else
    begin
      writeln('No match!');
      visible[x1, y1] := false;
      visible[x2, y2] := false;
    end;
    
    moves := moves + 1;
  until matches = SIZE * SIZE div 2;
  
  writeln('Congratulations! You won in ', moves, ' moves.');
end.
