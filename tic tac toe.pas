program TicTacToe;

const
  EMPTY = ' ';
  PLAYER_X = 'X';
  PLAYER_O = 'O';

type
  TBoard = array[1..3, 1..3] of char;

var
  board: TBoard;
  currentPlayer: char;

procedure InitializeBoard(var b: TBoard);
var
  i, j: integer;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      b[i, j] := EMPTY;
end;

procedure PrintBoard(b: TBoard);
var
  i, j: integer;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
    begin
      write(b[i, j]);
      if j < 3 then
        write(' | ');
    end;
    writeln;
    if i < 3 then
      writeln('--+---+--');
  end;
end;

function CheckWin(b: TBoard; player: char): boolean;
var
  i: integer;
begin
  for i := 1 to 3 do
  begin
    if (b[i, 1] = player) and (b[i, 2] = player) and (b[i, 3] = player) then
      exit(true);
    if (b[1, i] = player) and (b[2, i] = player) and (b[3, i] = player) then
      exit(true);
  end;
  if (b[1, 1] = player) and (b[2, 2] = player) and (b[3, 3] = player) then
    exit(true);
  if (b[1, 3] = player) and (b[2, 2] = player) and (b[3, 1] = player) then
    exit(true);
  CheckWin := false;
end;

function BoardFull(b: TBoard): boolean;
var
  i, j: integer;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      if b[i, j] = EMPTY then
        exit(false);
  BoardFull := true;
end;

procedure MakeMove(var b: TBoard; row, col: integer; player: char);
begin
  if b[row, col] = EMPTY then
    b[row, col] := player;
end;

procedure GetPlayerMove(var row, col: integer);
begin
  writeln('Enter row (1-3): ');
  readln(row);
  writeln('Enter column (1-3): ');
  readln(col);
end;

procedure SwitchPlayer(var player: char);
begin
  if player = PLAYER_X then
    player := PLAYER_O
  else
    player := PLAYER_X;
end;

begin
  InitializeBoard(board);
  currentPlayer := PLAYER_X;
  repeat
    PrintBoard(board);
    GetPlayerMove(row, col);
    MakeMove(board, row, col, currentPlayer);
    if CheckWin(board, currentPlayer) then
    begin
      PrintBoard(board);
      writeln('Player ', currentPlayer, ' wins!');
      break;
    end;
    if BoardFull(board) then
    begin
      PrintBoard(board);
      writeln('The game is a draw.');
      break;
    end;
    SwitchPlayer(currentPlayer);
  until false;
end.
