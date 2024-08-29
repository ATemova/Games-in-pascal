program ConnectFour;

uses crt;

const
  ROWS = 6;
  COLS = 7;
  EMPTY = ' ';
  PLAYER1 = 'X';
  PLAYER2 = 'O';

type
  TBoard = array[1..ROWS, 1..COLS] of char;

var
  board: TBoard;
  currentPlayer: char;
  col: integer;
  gameOver: boolean;

procedure InitializeBoard(var b: TBoard);
var
  i, j: integer;
begin
  for i := 1 to ROWS do
    for j := 1 to COLS do
      b[i, j] := EMPTY;
end;

procedure PrintBoard(b: TBoard);
var
  i, j: integer;
begin
  ClrScr;
  for i := 1 to ROWS do
  begin
    for j := 1 to COLS do
    begin
      write('|', b[i, j]);
    end;
    writeln('|');
  end;
  writeln('---------------');
  for j := 1 to COLS do
    write(' ', j, ' ');
  writeln;
end;

function IsColumnFull(b: TBoard; c: integer): boolean;
begin
  IsColumnFull := b[1, c] <> EMPTY;
end;

procedure DropDisc(var b: TBoard; c: integer; disc: char);
var
  r: integer;
begin
  for r := ROWS downto 1 do
  begin
    if b[r, c] = EMPTY then
    begin
      b[r, c] := disc;
      exit;
    end;
  end;
end;

function CheckWin(b: TBoard; disc: char): boolean;
var
  i, j, count: integer;
begin
  CheckWin := false;

  // Check horizontal
  for i := 1 to ROWS do
    for j := 1 to COLS - 3 do
      if (b[i, j] = disc) and (b[i, j + 1] = disc) and
         (b[i, j + 2] = disc) and (b[i, j + 3] = disc) then
        CheckWin := true;

  // Check vertical
  for i := 1 to ROWS - 3 do
    for j := 1 to COLS do
      if (b[i, j] = disc) and (b[i + 1, j] = disc) and
         (b[i + 2, j] = disc) and (b[i + 3, j] = disc) then
        CheckWin := true;

  // Check diagonal (bottom-left to top-right)
  for i := 1 to ROWS - 3 do
    for j := 1 to COLS - 3 do
      if (b[i, j] = disc) and (b[i + 1, j + 1] = disc) and
         (b[i + 2, j + 2] = disc) and (b[i + 3, j + 3] = disc) then
        CheckWin := true;

  // Check diagonal (top-left to bottom-right)
  for i := 4 to ROWS do
    for j := 1 to COLS - 3 do
      if (b[i, j] = disc) and (b[i - 1, j + 1] = disc) and
         (b[i - 2, j + 2] = disc) and (b[i - 3, j + 3] = disc) then
        CheckWin := true;
end;

begin
  InitializeBoard(board);
  currentPlayer := PLAYER1;
  gameOver := false;

  repeat
    PrintBoard(board);
    writeln('Player ', currentPlayer, ', enter the column (1-7): ');
    readln(col);

    if (col < 1) or (col > COLS) then
    begin
      writeln('Invalid column! Please enter a number between 1 and 7.');
      continue;
    end;

    if IsColumnFull(board, col) then
    begin
      writeln('Column is full! Try another column.');
      continue;
    end;

    DropDisc(board, col, currentPlayer);

    if CheckWin(board, currentPlayer) then
    begin
      PrintBoard(board);
      writeln('Player ', currentPlayer, ' wins!');
      gameOver := true;
    end
    else
    begin
      if currentPlayer = PLAYER1 then
        currentPlayer := PLAYER2
      else
        currentPlayer := PLAYER1;
    end;

  until gameOver;
end.
