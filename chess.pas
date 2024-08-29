program Chess;

type
  TBoard = array[1..8, 1..8] of char;

var
  board: TBoard;

procedure InitializeBoard(var b: TBoard);
var
  i: integer;
begin
  for i := 1 to 8 do
  begin
    b[2, i] := 'P';
    b[7, i] := 'p';
  end;
  
  b[1, 1] := 'R'; b[1, 8] := 'R';
  b[1, 2] := 'N'; b[1, 7] := 'N';
  b[1, 3] := 'B'; b[1, 6] := 'B';
  b[1, 4] := 'Q'; b[1, 5] := 'K';
  
  b[8, 1] := 'r'; b[8, 8] := 'r';
  b[8, 2] := 'n'; b[8, 7] := 'n';
  b[8, 3] := 'b'; b[8, 6] := 'b';
  b[8, 4] := 'q'; b[8, 5] := 'k';
  
  for i := 1 to 8 do
  begin
    b[3, i] := ' ';
    b[4, i] := ' ';
    b[5, i] := ' ';
    b[6, i] := ' ';
  end;
end;

procedure PrintBoard(b: TBoard);
var
  i, j: integer;
begin
  for i := 1 to 8 do
  begin
    for j := 1 to 8 do
      write(b[i, j]:2);
    writeln;
  end;
end;

procedure MovePiece(var b: TBoard; srcX, srcY, destX, destY: integer);
begin
  b[destX, destY] := b[srcX, srcY];
  b[srcX, srcY] := ' ';
end;

var
  srcX, srcY, destX, destY: integer;

begin
  InitializeBoard(board);
  repeat
    PrintBoard(board);
    writeln('Enter source (x y): ');
    readln(srcX, srcY);
    writeln('Enter destination (x y): ');
    readln(destX, destY);
    MovePiece(board, srcX, srcY, destX, destY);
  until false;
end.
