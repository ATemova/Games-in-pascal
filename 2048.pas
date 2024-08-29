program Game2048;

uses crt;

const
  SIZE = 4;

type
  TGrid = array[1..SIZE, 1..SIZE] of integer;

var
  grid: TGrid;
  score: integer;

procedure InitializeGrid(var g: TGrid);
var
  i, j: integer;
begin
  for i := 1 to SIZE do
    for j := 1 to SIZE do
      g[i, j] := 0;
  
  score := 0;
end;

procedure AddRandom(var g: TGrid);
var
  x, y: integer;
begin
  repeat
    x := random(SIZE) + 1;
    y := random(SIZE) + 1;
  until g[x, y] = 0;
  
  if random(10) = 0 then
    g[x, y] := 4
  else
    g[x, y] := 2;
end;

procedure PrintGrid(g: TGrid);
var
  i, j: integer;
begin
  ClrScr;
  writeln('Score: ', score);
  for i := 1 to SIZE do
  begin
    for j := 1 to SIZE do
    begin
      if g[i, j] = 0 then
        write('.':5)
      else
        write(g[i, j]:5);
    end;
    writeln;
  end;
end;

procedure MoveLeft(var g: TGrid; var score: integer);
var
  i, j, k: integer;
begin
  for i := 1 to SIZE do
  begin
    for j := 1 to SIZE - 1 do
    begin
      if g[i, j] = 0 then
      begin
        for k := j + 1 to SIZE do
        begin
          if g[i, k] <> 0 then
          begin
            g[i, j] := g[i, k];
            g[i, k] := 0;
            break;
          end;
        end;
      end;
      if (j < SIZE) and (g[i, j] = g[i, j + 1]) then
      begin
        g[i, j] := g[i, j] * 2;
        score := score + g[i, j];
        g[i, j + 1] := 0;
      end;
    end;
  end;
end;

procedure MoveRight(var g: TGrid; var score: integer);
var
  i, j, k: integer;
begin
  for i := 1 to SIZE do
  begin
    for j := SIZE downto 2 do
    begin
      if g[i, j] = 0 then
      begin
        for k := j - 1 downto 1 do
        begin
          if g[i, k] <> 0 then
          begin
            g[i, j] := g[i, k];
            g[i, k] := 0;
            break;
          end;
        end;
      end;
      if (j > 1) and (g[i, j] = g[i, j - 1]) then
      begin
        g[i, j] := g[i, j] * 2;
        score := score + g[i, j];
        g[i, j - 1] := 0;
      end;
    end;
  end;
end;

procedure MoveUp(var g: TGrid; var score: integer);
var
  i, j, k: integer;
begin
  for j := 1 to SIZE do
  begin
    for i := 1 to SIZE - 1 do
    begin
      if g[i, j] = 0 then
      begin
        for k := i + 1 to SIZE do
        begin
          if g[k, j] <> 0 then
          begin
            g[i, j] := g[k, j];
            g[k, j] := 0;
            break;
          end;
        end;
      end;
      if (i < SIZE) and (g[i, j] = g[i + 1, j]) then
      begin
        g[i, j] := g[i, j] * 2;
        score := score + g[i, j];
        g[i + 1, j] := 0;
      end;
    end;
  end;
end;

procedure MoveDown(var g: TGrid; var score: integer);
var
  i, j, k: integer;
begin
  for j := 1 to SIZE do
  begin
    for i := SIZE downto 2 do
    begin
      if g[i, j] = 0 then
      begin
        for k := i - 1 downto 1 do
        begin
          if g[k, j] <> 0 then
          begin
            g[i, j] := g[k, j];
            g[k, j] := 0;
            break;
          end;
        end;
      end;
      if (i > 1) and (g[i, j] = g[i - 1, j]) then
      begin
        g[i, j] := g[i, j] * 2;
        score := score + g[i, j];
        g[i - 1, j] := 0;
      end;
    end;
  end;
end;

var
  ch: char;
begin
  randomize;
  InitializeGrid(grid);
  AddRandom(grid);
  AddRandom(grid);
  
  repeat
    PrintGrid(grid);
    ch := readkey;
    
    case ch of
      'a': MoveLeft(grid, score);
      'd': MoveRight(grid, score);
      'w': MoveUp(grid, score);
      's': MoveDown(grid, score);
    end;
    
    AddRandom(grid);
  until false;
end.
